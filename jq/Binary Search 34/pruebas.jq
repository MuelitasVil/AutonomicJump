#jq -R -r -c -s -f muelasvill.jq

def calculate(A;B;C;D;x):
  (A * x) + 
  (B * ((x * x * x) | sqrt)) 
  - (C * ((-x / 50) | exp))
  - D
;

def abs(x):
  if x < 0 then 
    x * -1
  else 
    x
  end
;

def difference(x):
  abs(x) as $x
  | if $x < 0.0000001 then
    true
  else
    false
  end
;

def isleft(x):
  if x < 0 then 
    true
  else
    false 
  end 
;

def newDistance(x;start;endd):
  if isleft(x) then
    [((start + endd) / 2), endd]
  else
    [start, ((start + endd) / 2)]
  end
;

def getnumber(arrayInfo):
  (arrayInfo[0] | tonumber) as $A
  | (arrayInfo[1] | tonumber) as $B
  | (arrayInfo[2] | tonumber) as $C 
  | (arrayInfo[3] | tonumber) as $D 
  | 0 as $start 
  | 100 as $endd
  | 0 as $i
  | calculate($A;$B;$C;$D;(($start + $endd) / 2)) as $x
  | [$start,$endd,$x, $i]
  | until
  (
    difference(.[2]);   
    [
      .[0] as $Start 
      | .[1] as $End
      | .[2] as $X 
      | newDistance($X;$Start;$End)[0]
      ,
      .[0] as $Start 
      | .[1] as $End
      | .[2] as $X 
      | newDistance($X;$Start;$End)[1]
      ,
      .[0] as $Start 
      | .[1] as $End
      | .[2] as $X 
      | newDistance($X;$Start;$End) as $newDistan
      | $newDistan[0] as $newStart
      | $newDistan[1] as $newEnd
      | calculate($A;$B;$C;$D;(($newStart + $newEnd) / 2))
      ,
      .[3] + 1
    ])
    | [.[0],.[1],.[2],.[3]] as $rta 
    | (($rta[0] + $rta[1]) / 2)
;

def DivideNums:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $element 
  | [getnumber($element) | tostring, " "]
  | add]
  | add
;

def main:
  if length < 1 then  empty
  else DivideNums
  end
;

main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# 16.924347588792443 58.67004110477865 46.82535850442946 77.8705001110211
# 64.07525179092772 77.51293927431107 35.064607311505824 47.67270837910473
