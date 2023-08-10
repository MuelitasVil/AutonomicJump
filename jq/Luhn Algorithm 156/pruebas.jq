#jq -R -r -c -s -f muelasvill.jq

def calculateNumber(number;index):
  (number | tonumber) as $number
  | if index % 2 == 0  then 
    $number 
  elif $number > 4 then 
    ($number * 2) - 9
  else  
    ($number * 2)
  end 
  ; 

def getNumberEven(summation;div10):
  (((div10 + 1) * 10) - summation)
;

def getNumberOdd(summation;div10):
  (((div10 + 1) * 10) - summation) as $difference
  | {
     "0" : 0,
     "2" : 1,
     "4" : 2,
     "6" : 3,
     "8" : 4,
     "1" : 5,
     "3" : 6,
     "5" : 7,
     "7" : 8,
     "9" : 9,
  } as $dictOfvalues 
  | $dictOfvalues[($difference | tostring)]
;

def travelNumber(numbers;badindex;numberFound):
   badindex as $unknownIndex
  | numbers as $numbers 
  | [ ($numbers | length) as $size
  | [range($size)] as $indices
  | $indices 
  | .[] as $index
  | if $index != $unknownIndex then
    $numbers[$index]
    else 
    numberFound | tostring
    end]
;

def travelSwap(numbers;index):
  index as $Index
  | numbers as $numbers 
  | [ ($numbers | length) as $size
  | [range($size)] as $indices
  | $indices 
  | .[] as $index
  | if $index == $Index then
    $numbers[$index + 1]
    elif $index == $Index + 1  then
    $numbers[$index - 1]
    else 
    $numbers[$index]
    end]
;

def NumbersUnknown(numbers; badindex):
  badindex[0] as $unknownIndex
  | numbers as $numbers 
  | [ ($numbers | length) as $size
  | [range($size)] as $indices
  | $indices 
  | .[] as $index
  | if $index != $unknownIndex then
    calculateNumber($numbers[$index]; $index)
    else 
    0
    end]  as $newNumbers
  | ($newNumbers | add) as $sumNumbers 
  | ($sumNumbers % 10) as $mod10
  | (($sumNumbers / 10) | floor) as $div10
  | if $mod10 == 0 then
    travelNumber($numbers;$unknownIndex;0)
    | reverse
    elif $unknownIndex % 2 != 0 then
    travelNumber($numbers;$unknownIndex;getNumberOdd($sumNumbers;$div10))
    | reverse
    else
    travelNumber($numbers;$unknownIndex;getNumberEven($sumNumbers;$div10))
    | reverse
    end
;

def NumbersSwap(numbers):
  [[] as $SwapNumbers 
  | numbers as $numbers 
  | ($numbers | length) as $size
  | [range($size - 1)] as $indices
  | $indices 
  | .[] as $index
  | [[range($index)] as $left
  | [range($index + 2; 16)] as $rigth
  | ([$left , [$index + 1, $index], $rigth] | add) as $SwapIndices
  | $SwapIndices
  | .[] as $newIndex
  | if $newIndex == $index then  
    calculateNumber($numbers[$newIndex]; $newIndex + 1) 
    elif $newIndex == $index + 1 then
    calculateNumber($numbers[$newIndex]; $newIndex - 1)
    else
    calculateNumber($numbers[$newIndex]; $newIndex)
    end 
  ] 
  | add as $summation
  | if $summation % 10 == 0 then 
    $index
    else
    empty
    end
  ] as $swapsIndex
  | $swapsIndex[-1] as $swapIndex
  | travelSwap(numbers; $swapIndex)
  | reverse
  
;

def DivideNums:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $element 
  | $element | add | split("") | reverse as $numbers
  | ($numbers | indices("?")) as $unknownDigits
  | if ($unknownDigits | length)  > 0 then
    [NumbersUnknown($numbers;$unknownDigits), [" "]] 
    | add
    | add
    else
    [NumbersSwap($numbers), [" "]]
    | add
    | add
    end 
    ] | add 
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