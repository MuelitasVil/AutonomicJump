#jq -r -c -s -f muelasvill.jq

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
  def lenn(num1; num2):
    (num1|length) as $l1 | (num2|length) as $l2
    | $l1 < $l2 or ($l1 == $l2 and num1 <= num2);
  num1[0:1] as $s1 | num2[0:1] as $s2
  | if num1 == num2 or ($s1 == "-" and $s2 != "-") then true
  elif  ($s1 != "-" and $s2 == "-") then false
  elif  ($s1 == "-" and $s2 == "-") then lenn( num2[1:]; num1[1:])
  else lenn(num1; num2)
  end;

def long_add(num1; num2):
  def stripsign:
    .[0:1] as $a
    | if $a == "-" then [ -1, .[1:]] 
      elif $a == "+" then [  1, .[1:]] 
      else [1, .]
      end;

  def add(num1;num2):
  if (num1|length) < (num2|length) then add(num2;num1)
  else  (num1 | explode | map(.-48) | reverse) as $a1
      | (num2 | explode | map(.-48) | reverse) as $a2
      | reduce range(0; num1|length) as $ix
          ($a2;  
           ( $a1[$ix] + .[$ix] ) as $r
           | if $r > 9 
             then
               .[$ix + 1] = ($r / 10 | floor) +  
               (if $ix + 1 >= length then 0 else .[$ix + 1] end)
               | .[$ix] = $r - ( $r / 10 | floor ) * 10
             else
               .[$ix] = $r
             end )
      | reverse | map(.+48) | implode
  end ;

  def complement_plus1: 
    if type == "string" 
    then explode | map(105 - .) | implode | long_add(.;"1")
    else map(105 - .) | implode | long_add(.;"1") | explode
    end ;
  
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
  end;

def long_minus(x;y):
  long_add( x; y | negate);

def long_multiply(num1; num2):
  def stripsign:
    .[0:1] as $a
    | if $a == "-" then [ -1, .[1:]] 
    elif $a == "+" then [  1, .[1:]] 
    else [1, .]
    end;
  def adjustsign(sign):
     if sign == 1 then . else "-" + . end;
  def mult(num1;num2):
      (num1 | explode | map(.-48) | reverse) as $a1
    | (num2 | explode | map(.-48) | reverse) as $a2
    | reduce range(0; num1|length) as $i1
        ([];  
         reduce range(0; num2|length) as $i2
           (.;
            ($i1 + $i2) as $ix
            | ( $a1[$i1] * $a2[$i2] + 
            (if $ix >= length then 0 else .[$ix] end) ) as $r
            | if $r > 9 
              then
                .[$ix + 1] = ($r / 10 | floor) +  
                (if $ix + 1 >= length then 0 else .[$ix + 1] end)
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
    elif $a1[1] == "1" then $a2[1]|adjustsign( $a1[0] * $a2[0])
    elif $a2[1] == "1" then $a1[1]|adjustsign( $a1[0] * $a2[0])
    else mult($a1[1]; $a2[1]) | adjustsign( $a1[0] * $a2[0] )
    end;

def long_power(i):

  def power(i): tostring as $self
    | if i == 0 then "1"
      elif i == 1 then $self
      elif ($self == "0") then "0"
      elif ($self == "1") then "1"
      else reduce range(1;i) as $_ ( $self; long_multiply(.; $self))
      end;

  def check:  
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

def long_divide(x;y):

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

  def _divide(x;y): 
    if x == y then ["1", "0"]
    elif y == "1" then [x, "0"]
    elif y == "0" then error("cannot divide \(x) by 0")
    else (x|length) as $xlength | (y|length) as $ylength
      | if $xlength < $ylength or 
      ( $xlength == $ylength and x < y ) then [ "0", x ]
        else
          reduce range(0; $xlength) as $i
            ( ["",""];      
              .[0] as $q | (.[1] + "0") as $r
              | (long_add($r; x[$i:$i+1])) as $num
              | [0, "0"] | divvy($num; y)
              | ( "-" + .[1]) as $negate
              | [ ($q + (.[0]|tostring)), long_add($num; $negate) ]
            )
        end
      | map(ltrim)
    end;

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
  def rgcd:
    .[0] as $a | .[1] as $b
    | if $b == "0" then $a
      else long_mod($a ; $b ) as $lm
      | [$b, $lm ] | rgcd
      end;
  [a, b] | rgcd | long_abs ;

def ModularInverse(numAndMod): 
  numAndMod[0] as $g0
  | numAndMod[1] as $g1
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
    .[1],
    .[0] as $g_1
    | .[1] as $g
    | long_minus($g_1;long_multiply(long_div($g_1;$g);$g)),        
    
    .[3],
    
    .[0] as $g_1
    | .[1] as $g
    | .[2] as $u_1
    | .[3] as $u
    | long_minus($u_1;long_multiply(long_div($g_1;$g);$u)),
    .[5], 
    
    .[0] as $g_1
    | .[1] as $g
    | .[4] as $v_1
    | .[5] as $v
    | long_minus($v_1;long_multiply(long_div($g_1;$g);$v)),
  
    .[6] + 1
   ]
  ) 
  | .[4] as $v_1
  | if lessOrEqual($v_1;"-1") then 
    long_add($v_1; $g0) 
    else 
    $v_1
    end
;

def long_modSigned(num;mod):
  if lessOrEqual(num;"0") then 
  long_minus(mod;long_mod(num | long_abs ;mod))
  else 
  long_mod(num;mod)
  end
;

def getX(MxAxB):
  (MxAxB[0]) as $m
  | (MxAxB[1]) as $a
  | (MxAxB[2]) as $b
  | ModularInverse([$m, $a]) as $invmod 
  | long_modSigned(long_multiply($invmod;$a); $m) as $chechMod
  | if $chechMod != "1" then 
    "-1"
    else 
    long_modSigned(long_multiply((["-" , $b] | add);$invmod);$m)
    end
;

def DivideNums:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $element 
  | [(getX($element)| tostring)," "]
  | add
  ]
  | add
;

def main:

  if length < 1 then  empty
  else  DivideNums
  end 

;
main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# -1 20078885 189857 -1 -1 51614 44981 -1 -1 -1 720665191 -1 9872375 5131656
# 286820801 3737554 -1 42971 -1 1037508 -1 -1 3393567 504870097 81368797
# -1 -1 14885985 67803159 16710 -1