#jq -R -r -c -s -f muelasvill.jq

def PositionOfTreasure(information):
  information as $information
  | ($information | length) as $size
  | 0 as $index
  | 0 as $X
  | 0 as $Y
  | [$index, $X, $Y]
  | until
  (
    .[0] >= $size;

    [
      .[0] as $index
      | $index + 1,
        
      .[0] as $index
      | .[1] as $X
      | $information[$index] as $array
      | $array[0] as $steps
      | $array[1] as $direction
      | ($direction | sin) as $directionX
      | ($X + ($steps * $directionX)),

      .[0] as $index
      | .[2] as $Y
      | $information[$index] as $array
      | $array[0] as $steps
      | $array[1] as $direction
      | ($direction | cos) as $directionY
      | ($Y + ($steps * $directionY))
    ]
  ) 
  | [(.[1] | round),(.[2] | round)]
;

def getRadians(num):
  (num | tonumber) as $num 
  | ($num) * (3.141592653589793 / 180)
;

def DivideInformation:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-2]
  | .[] 
  | split(" ") as $element
  | [($element[1] | tonumber),getRadians(($element[5] | tonumber),$element[5])]
  ] as $information 
  | PositionOfTreasure($information) as $FinalPosition
  | [($FinalPosition[0] | tostring)," ",($FinalPosition[1] | tostring)]
  | add
;

def main:
  if length < 1 then  empty
  else DivideInformation
  end
;

main 

# cat DATA.lst | jq -R -r -c -s -f muelassvill.jq
# -404 3001
