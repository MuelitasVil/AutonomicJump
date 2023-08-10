#jq -R -r -c -s -f muelasvill.jq
      

def getSuit(number):
  ((number / 13) | floor)
;

def getRank(number):
  (number % 13)
;

def DivideNums:
  [
  . 
  | split("\n") as $setOfNums
  | ["2", "3", "4", "5", "6", "7", "8", "9", "10",
     "Jack", "Queen", "King", "Ace"] as $ranks
  | ["Clubs", "Spades", "Diamonds", "Hearts"] as $suits
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $ArrayOfElements
  | $ArrayOfElements
  | (.[] | tonumber) as $element
  | getRank($element) as $RankValue
  | getSuit($element) as $RankSuit
  | [$ranks[$RankValue],"-","of","-",$suits[$RankSuit]," "]
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
# (1 35084) (7 8456) (1 5536) (1 5502) (8 80) (24 18240) (56 91448) (1 2328)
# (840 60480) (58 133110) (1 61012) (13 12740) (2 10504) (375 5625)
# (480 12480) (1 4689591) (2 622) (2 2) (3 20925) (83 440481)
