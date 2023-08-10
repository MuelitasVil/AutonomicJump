def negate: 
  if . == "0" or . == "+0" or . == "-0" then "0"
  elif type == "number" then (-.|tostring) 
  else .[0:1] as $s
    | if   $s == "-" then .[1:]
      elif $s == "+" then "-" + .[1:] 
      else "-" + .
      end
  end ;

def lessOrEqual(num1; num2):
  def lenn(num1; num2): # for non-negatives
    (num1|length) as $l1 | (num2|length) as $l2
    # for non-negatives of equal length, can use <=
    | $l1 < $l2 or ($l1 == $l2 and num1 <= num2);

  num1[0:1] as $s1 | num2[0:1] as $s2
  | if num1 == num2 or ($s1 == "-" and $s2 != "-") then true
  elif  ($s1 != "-" and $s2 == "-") then false
  elif  ($s1 == "-" and $s2 == "-") then lenn( num2[1:]; num1[1:] )
  else lenn(num1; num2)
  end;

def long_add(num1; num2):

  def stripsign:
    .[0:1] as $a
    | if $a == "-" then [ -1, .[1:]] 
      elif $a == "+" then [  1, .[1:]] 
      else [1, .]
      end;

  # The workhorse assumes non-negative integers:
  def add(num1;num2):
  if (num1|length) < (num2|length) then add(num2;num1)
  else  (num1 | explode | map(.-48) | reverse) as $a1
      | (num2 | explode | map(.-48) | reverse) as $a2
      | reduce range(0; num1|length) as $ix
          ($a2;  # result
           ( $a1[$ix] + .[$ix] ) as $r
           | if $r > 9 # carrying
             then
               .[$ix + 1] = ($r / 10 | floor) +  (if $ix + 1 >= length then 0 else .[$ix + 1] end )
               | .[$ix] = $r - ( $r / 10 | floor ) * 10
             else
               .[$ix] = $r
             end )
      | reverse | map(.+48) | implode
  end ;

  # If input is a string, output a string; if input is an exploded
  # string, then output an exploded string; output the 9s complement plus 1,
  #  e.g. "11" => "89"
  def complement_plus1: # [48] is "0", and 2*48 + 9 is 105:
    if type == "string" then explode | map(105 - .) | implode | long_add(.;"1")
    else map(105 - .) | implode | long_add(.;"1") | explode
    end ;
  
  # For num1 >= 0 and num2 >= 0
  def minus(num1; num2):
    def ltrim:
      if length <= 1 then .
      elif .[0:1] == "0" then (.[1:]|ltrim)
      else .
      end ;
  
    if num1 == num2 then "0"
    elif num2 == "0" or num2 == "-0" then num1
    elif num1 == "0" or num1 == "-0" then "-" + num2
    else
      (num1|length) as $l1 | (num2|length) as $l2
      | if $l1 > $l2 or ($l1 == $l2 and num1 > num2) 
        then
          ("9"*($l1 - $l2)  + (num2|complement_plus1)) as $c
          | (long_add(num1; $c))[1:] | ltrim
        else 
          "-" + minus(num2; num1)
        end
    end ;

  if num1 == "0" then num2
  elif num2 == "0" then num1
  else
    (num1|stripsign) as $a1
  | (num2|stripsign) as $a2
  | if $a1[0]*$a2[0] == 1 then 
      add($a1[1]; $a2[1]) as $sum
      | if $a1[0] == 1 then $sum else $sum | negate end
    elif $a1[0] == 1 then minus($a1[1]; $a2[1])
    else minus($a2[1]; $a1[1])
    end
  end ;

def long_minus(x;y):
  long_add( x; y | negate);

# multiply two decimal strings, which may be signed (+ or -)
def long_multiply(num1; num2):

  def stripsign:
    .[0:1] as $a
    | if $a == "-" then [ -1, .[1:]] 
    elif $a == "+" then [  1, .[1:]] 
    else [1, .]
    end;

  def adjustsign(sign):
     if sign == 1 then . else "-" + . end;

  # mult/2 assumes neither argument has a sign
  def mult(num1;num2):
      (num1 | explode | map(.-48) | reverse) as $a1
    | (num2 | explode | map(.-48) | reverse) as $a2
    | reduce range(0; num1|length) as $i1
        ([];  # result
         reduce range(0; num2|length) as $i2
           (.;
            ($i1 + $i2) as $ix
            | ( $a1[$i1] * $a2[$i2] + (if $ix >= length then 0 else .[$ix] end) ) as $r
            | if $r > 9 # carrying
              then
                .[$ix + 1] = ($r / 10 | floor) +  (if $ix + 1 >= length then 0 else .[$ix + 1] end )
                | .[$ix] = $r - ( $r / 10 | floor ) * 10
              else
                .[$ix] = $r
              end
         )
        ) 
    | reverse | map(.+48) | implode;

  (num1|stripsign) as $a1
  | (num2|stripsign) as $a2
  | if $a1[1] == "0" or  $a2[1] == "0" then "0"
    elif $a1[1] == "1" then $a2[1]|adjustsign( $a1[0] * $a2[0] )
    elif $a2[1] == "1" then $a1[1]|adjustsign( $a1[0] * $a2[0] )
    else mult($a1[1]; $a2[1]) | adjustsign( $a1[0] * $a2[0] )
    end;


# Emit (input)^i where input and i are non-negative decimal integers, represented as numbers and/or strings.
# An error may be raised if i > 2^32
def long_power(i):

  # int is an integer
  def power(i): tostring as $self
    | if i == 0 then "1"
      elif i == 1 then $self
      elif ($self == "0") then "0"
      elif ($self == "1") then "1"
      else reduce range(1;i) as $_ ( $self; long_multiply(.; $self) )
      end;

  def check:  # check that . is not way too big (2^28)
    if type == "number" and . <= 268435456 then .
    elif lessOrEqual(.; "268435456") then tonumber
    else error("long_power: \(.) is too large")
    end;

  if i == 0 or i == "0" then "1"
  else tostring as $self
  | if i == 1 or i == "1" then $self
    elif ($self == "0") then "0"
    elif ($self == "1") then "1"
    else (i|check) as $i
    | if $i < 4 then power($i)
      else ($i|sqrt|floor) as $j
      | ($i - $j*$j) as $k
      | long_multiply( power($j) | power($j) ; power($k) )
      end
    end
  end;


# return [quotient, remainder] 
# 0/0 = 1; n/0 => error
def long_divide(x;y):  # x/y => [q,r]

  def stripsign:
    .[0:1] as $a
    | if $a == "-" then [ -1, .[1:]] 
    elif $a == "+" then [  1, .[1:]] 
    else [1, .]
    end;

  def ltrim:
    if length <= 1 then .
    elif .[0:1] == "0" then (.[1:]|ltrim)
    else .
    end ;

  # divvy(num; yy) - input and output are [m, sum] where:
  #    num and sum are strings representing non-negative integers;
  # On conclusion, assuming num and yy are positive,
  # m is the maximum integer such that m * yy == sum <= num
  def divvy(num; yy):
    (num|ltrim) as $n
    | if $n == "0" then .
      else
        .[0] as $m | .[1] as $sum
        | long_add($sum; yy) as $sum1
        | if lessOrEqual($sum1; $n)
          then [$m + 1, $sum1] | divvy($n; yy)
          else .
          end
    end;

  # [quotient; remainder]
  def _divide(x;y): # x and y are non-negative
    if x == y then ["1", "0"]
    elif y == "1" then [x, "0"]
    elif y == "0" then error("cannot divide \(x) by 0")
    else (x|length) as $xlength | (y|length) as $ylength
      # if the strings have the same length then we can use <
      | if $xlength < $ylength or ( $xlength == $ylength and x < y ) then [ "0", x ]
        else
          reduce range(0; $xlength) as $i
            ( ["",""];      # state: [q, r]
              .[0] as $q | (.[1] + "0") as $r
              | (long_add($r; x[$i:$i+1])) as $num
              | [0, "0"] | divvy($num; y)
              | ( "-" + .[1]) as $negate
              | [ ($q + (.[0]|tostring)), long_add($num; $negate) ]
            )
        end
      | map(ltrim)
    end;

  # Ready at last:
    (x|stripsign) as $sx
  | (y|stripsign) as $sy
  | _divide($sx[1]; $sy[1])
  | if   $sx[0] == 1 and $sy[0] == 1 then .
    elif $sx[0] == 1  and $sy[0] == -1 then .[0] = (.[0]|negate)
    elif $sx[0] == -1 and $sy[0] == -1 then .[1] = (.[1]|negate) 
    else map(negate)
    end;

def long_div(x;y):
  long_divide(x;y) | .[0];

def long_mod(x;y):
  long_divide(x;y) | .[1];

def long_abs:
  . as $in
  | if lessOrEqual("0"; $in) then $in else negate end;

def gcd(a; b):
  # subfunction rgcd expects [a,b] as input
  # i.e. a ~ .[0] and b ~ .[1]
  def rgcd:
    .[0] as $a | .[1] as $b
    | if $b == "0" then $a
      else long_mod($a ; $b ) as $lm
      | [$b, $lm ] | rgcd
      end;
  [a, b] | rgcd | long_abs ;

def long_modSigned(num;mod):
  if lessOrEqual(num;"0") then 
  long_minus(mod;long_mod(num | long_abs ;mod))
  else 
  long_mod(num;mod)
  end
;


def ModularInverse(numAndMod): 
  numAndMod[1] as $g0
  | numAndMod[0] as $g1
  | "1" as $u0
  | "0" as $u1
  | "0" as $v0
  | "1" as $v1
  | 1 as $i
  | [$g0, $g1, $u0, $u1, $v0, $v1, $i]
  | until
  (
    .[1] == "0";
    [
    #g-1 0
    .[1],
    #g 1
    .[0] as $g_1
    | .[1] as $g
    | long_minus($g_1;long_multiply(long_div($g_1;$g);$g)),  
    #u - 1 2
    .[3],
    #u 3 
    .[0] as $g_1
    | .[1] as $g
    | .[2] as $u_1
    | .[3] as $u
    | long_minus($u_1;long_multiply(long_div($g_1;$g);$u)),
    #| $u_1 - ((($g_1 / $g) | floor) * $u),     
    #v - 1
    .[5], 
    #v1
    .[0] as $g_1
    | .[1] as $g
    | .[4] as $v_1
    | .[5] as $v
    | long_minus($v_1;long_multiply(long_div($g_1;$g);$v)),
    #| $v_1 - ((($g_1 / $g) | floor) * $v),
     #i  
    .[6] + 1
   ]
  ) #| .[6]
  | .[4] as $v_1
  | if lessOrEqual($v_1;"-1") then 
    long_add($v_1; $g0) 
    else 
    $v_1
    end
;


def main:
    
  "12543906180461946496" as $num0
  | "5048678836385112687" as $num1
  | "12532419960800109894" as $num2
  | ModularInverse(["47657608","414175313"])
  #| long_div("275";"9")
;

main