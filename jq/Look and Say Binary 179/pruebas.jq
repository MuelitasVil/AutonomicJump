#jq -R -r -c -s -f muelasvill.jq

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
    
def PowerOfTwo(raised):
  raised as $raised
  | ["2",1]
  | until
   ( 
    .[1] >= $raised; 
    [
      .[0] as $num
      | long_multiply($num;"2"),
      
      .[1] + 1
    
    ]
    )
    |.[0]
;
def IntegerToBinary(number):
  [number,""]
  |
  until(
    .[0] <= 0;
    [
    ((.[0] / 2) | floor), 
     
    .[1] + ((.[0] % 2) | tostring)
    ])
  | .[1]
  | split("")
  | reverse 
  | add
;

def getGroupOfBits(bits):
  (bits | split("")) as $bits
  | ($bits | length) as $size
  | 0 as $star
  | 0 as $endd
  | [$star,$endd, "1", []]
  | until
  (
    .[1] > $size; 
    [
      .[0] as $star 
      | .[1] as $endd
      | .[2] as $bit
      | if ($bit != $bits[$endd]) then
        $endd
        else 
        $star
        end, 
      
      .[1] as $endd
      | $endd + 1,

      .[0] as $star 
      | .[1] as $endd
      | .[2] as $bit
      | if ($bit != $bits[$endd]) then
          if $bit == "1" then
            "0"
          else 
            "1"
          end   
        else 
        $bit
        end
      , 
      .[0] as $star 
      | .[1] as $endd
      | .[2] as $bit
      | .[3] as $groupOfBits
      | if ($bit != $bits[$endd]) then
        $groupOfBits + [$bits[$star:$endd]]
        else 
        $groupOfBits
        end
    ]
  )
  | .[3]
;

def getChildren(bits):
  (bits | split("")) as $bits
  | ($bits | length) as $size
  | 0 as $star
  | 0 as $endd
  | [$star,$endd,[]]
  | until
  (
    .[1] > $size; 
    [
      .[0] as $star 
      | .[1] as $endd
      | if ($bits[$endd] == "1") then
        $endd
        else 
        $star
        end, 
      
      .[1] as $endd
      | $endd + 1,

      .[0] as $star 
      | .[1] as $endd
      | .[2] as $groupOfBits
      | if ($bits[$endd] == "1") then
        $groupOfBits + [$bits[$star:$endd]]
        else 
        $groupOfBits
        end
    ]
  )
  | .[2]
;

def newGropOfBits(groupOfBits):
  [
  groupOfBits
  | .[] as $element
  | ($element  | length) as $size
  | IntegerToBinary($size) 
  ]
;

def GetInformation:
  . as $info
  | split("\n") as $setOfNums
  | $setOfNums[0:-1]
  | .[] as $element
  | $element
  | [$element, 0]
  | until
  (
    .[0] == "10"; 
    [
      (.[0] as $element
      | getGroupOfBits($element) as $groupOfBits
      | newGropOfBits($groupOfBits)
      | add), 

      (.[1] + 1)
    ]
  )
  | .[1] as $steps
  | getChildren($element) as $childrens
  | (($childrens | length) - 1) as $cantOfChildrens
  | [$steps | tostring," ",PowerOfTwo($cantOfChildrens)]
  | add


;

def main:
  if length < 1 then  empty
  else GetInformation
  end
;
main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# 16 2361183241434822606848