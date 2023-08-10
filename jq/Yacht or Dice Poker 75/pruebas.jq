#jq -R -r -c -s -f muelasvill.jq
      
def GetCantOfPoints(diceRolls):
  diceRolls as $diceRolls
  | (($diceRolls | indices("1")) | length) as $cantOfOne
  | (($diceRolls | indices("2")) | length) as $cantOfTwo
  | (($diceRolls | indices("3")) | length) as $cantOfThree
  | (($diceRolls | indices("4")) | length) as $cantOfFour
  | (($diceRolls | indices("5")) | length) as $cantOfFive
  | (($diceRolls | indices("6")) | length) as $cantOfSix
  | [$cantOfOne,$cantOfTwo,$cantOfThree,$cantOfFour,$cantOfFive,$cantOfSix]
;

def isSmallStraight(resultOfGame):
  resultOfGame as $resultOfGame
  | if ($resultOfGame[0] == 1) and ($resultOfGame[1] == 1) 
    and ($resultOfGame[2] == 1) and  ($resultOfGame[3] == 1)
    and ($resultOfGame[4] == 1) then
    true
    else 
    false
    end 
;

def isBigStraight(resultOfGame):
  resultOfGame as $resultOfGame
  | if ($resultOfGame[1] == 1) and ($resultOfGame[2] == 1) 
    and ($resultOfGame[3] == 1) and  ($resultOfGame[4] == 1)
    and ($resultOfGame[5] == 1) then
    true
    else 
    false
    end 
;  
  
def verifyGame(resultOfGame):
  resultOfGame as $resultOfGame
  | (($resultOfGame | indices(2)) | length) as $pairs
  | (($resultOfGame | indices(3)) | length) as $three
  | (($resultOfGame | indices(4)) | length) as $four
  | (($resultOfGame | indices(5)) | length) as $yacht
  | if $three == 1 and $pairs == 1 then 
      "full-house "
    elif $pairs == 2 then 
      "two-pairs "
    elif $three == 1 then
      "three "
    elif $four == 1 then 
      "four " 
    elif $pairs == 1 then 
      "pair "
    elif $yacht == 1 then
      "yacht "
    elif isSmallStraight($resultOfGame) then
      "small-straight "
    elif isBigStraight($resultOfGame) then
      "big-straight "
    else 
      "none "
    end
;

def DivideNums:
  [
  . 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $diceRolls
  | GetCantOfPoints($diceRolls) as $resultOfGame
  | verifyGame($resultOfGame)
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
# big-straight full-house big-straight yacht pair small-straight
# small-straight pair yacht yacht yacht yacht small-straight 
# yacht big-straight three pair three small-straight pair 
# three none big-straight two-pairs two-pairs pair 
# big-straight pair three big-straight small-straight
