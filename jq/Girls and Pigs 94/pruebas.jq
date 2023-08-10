#jq -R -r -c -s -f muelasvill.jq

def getSetOfLegs(maxPigs;minGirls):
  [maxPigs, minGirls, []]
  | until
  (
    .[0] < 1; 
    
    [
      .[0] - 1, 

      .[1] + 2,

      .[2] + [[.[0], .[1]]]
    ]
  )
  |.[2] 
;

def getSetOfBreasts(getSetOfLegs):
  [
    getSetOfLegs
  | .[] as $element
  | [$element[0],$element[1],($element[1] * 2)]
  ]
;  

def getMaxPigsAndMinGirls(legs;breasts):
  4 as $legsOfPigs
  | 2 as $legsOfGirls 
  | ((legs / $legsOfPigs) | floor) as $maxPigs
  | (((legs % $legsOfPigs) / 2) | floor) as $minGirls
  | if (legs % $legsOfPigs == 0) then 
      [$maxPigs - 1, 2]
    else 
      [$maxPigs,$minGirls]
    end
;

def isPosible(breasts;BreastsGirls):
  if ((breasts - BreastsGirls[2]) % BreastsGirls[0]) == 0
  and  (((breasts - BreastsGirls[2]) / BreastsGirls[0]) | floor)  % 2 == 0
  then
    true
  else 
    false
  end
; 

def getResults(legs;breasts):
  [getMaxPigsAndMinGirls(legs;breasts) as $Range
  | $Range[0] as $maxPigs
  | $Range[1] as $minGirls
  | getSetOfLegs($maxPigs;$minGirls) as $getSetOfLegs
  | getSetOfBreasts($getSetOfLegs) as $getSetOfBreastsGirls
  | $getSetOfBreastsGirls
  | .[] as $BreastsGirls
  | if isPosible(breasts;$BreastsGirls) then
    $BreastsGirls
  else 
    empty
  end
  ]
;
      
def DivideNums:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $element 
  | ($element[0] | tonumber) as $legs
  | ($element[1] | tonumber) as $breasts
  | getResults($legs;$breasts)
  | length as $cantOfSolutions 
  | [($cantOfSolutions | tostring), " "]
  | add
  ]
  | add
;

def main:
  if length < 1 then  empty
  else DivideNums
  end
;
main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# 13 14 30 4 6 17 3 5 10 2 3 4 25
