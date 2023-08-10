#jq -R -r -c -s -f muelasvill.jq

def getSlope(arrayPoints):
  (arrayPoints[0] | tonumber) as $x0 
  | (arrayPoints[1] | tonumber) as $y0
  | (arrayPoints[2] | tonumber) as $x1
  | (arrayPoints[3] | tonumber) as $y1 
  | (($y1 - $y0) / ($x1 - $x0)) as $slope 
  | $slope
;

def getConstant(arrayPoints; s):
  (arrayPoints[2] | tonumber) as $x
  | (arrayPoints[3] | tonumber) as $y
  | s as $slope 
  | ($y - ($x * $slope)) as $constant
  | $constant
;  

def DivideNums:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $element 
  | getSlope($element) as $slope
  | getConstant($element;$slope) as $constant
  | ["(",($slope | tostring)," ", ($constant | tostring),")"," "]
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