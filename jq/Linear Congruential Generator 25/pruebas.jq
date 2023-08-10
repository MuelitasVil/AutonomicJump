#jq -R -r -c -s -f muelasvill.jq

def getnumber(arrayInfo):
  (arrayInfo[0] | tonumber) as $A
  | (arrayInfo[1] | tonumber) as $C
  | (arrayInfo[2] | tonumber) as $M
  | (arrayInfo[3] | tonumber) as $X0
  | (arrayInfo[4] | tonumber) as $N
  | [0, $X0]
  |until(
    .[0] >= $N; 
    [
    .[0] + 1,

    .[1] as $X
    | (($A * $X) + $C) % $M
    ])
  |.[1]
;

def DivideNums:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $element 
  | [getnumber($element) | tostring , " "]
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
# (-31 952) (63 619) (-51 -681) (87 577) (50 168) (-51 69) (47 -508)
# (-82 -912) (-32 -671) (40 -557) (22 -311) (60 -759) (74 -91) (74 832) 