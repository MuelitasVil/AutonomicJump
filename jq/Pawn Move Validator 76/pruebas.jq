#jq -R -r -c -s -f muelasvill.jq

def editChessBoard(chessboard;fill_0;column_0;fill_1;column_1):
  chessboard 
  | .[fill_0][column_0] as $temp
  | .[fill_1][column_1] = $temp  
  | .[fill_0][column_0] = "  "
;

def TraductionOfMoves(game):
  {
    "a" : 0,
    "b" : 1,
    "c" : 2,
    "d" : 3,
    "e" : 4,
    "f" : 5,
    "g" : 6,
    "h" : 7,
  } as $columnDict
  | 
  {
    "8" : 0,
    "7" : 1,
    "6" : 2,
    "5" : 3,
    "4" : 4,
    "3" : 5,
    "2" : 6,
    "1" : 7,
  } as $fillDict
  | 
  [
    game 
    | (.[] | split("")) as $move
    | $columnDict[$move[0]] as $column_0
    | $fillDict[$move[1]] as $fill_0
    | $columnDict[$move[2]] as $column_1
    | $fillDict[$move[3]] as $fill_1
    | [[$fill_0,$column_0],[$fill_1,$column_1]]
  ]
;

def verifyPeon(chessboard;fill_0;column_0;fill_1;column_1):
  chessboard as $chessboard
  | ($chessboard[fill_0][column_0] | split("")) as $Pawn
  | ($chessboard[fill_1][column_1] | split("")) as $Enemy
  | ($chessboard[fill_0 + 1][column_0]) as $front1B
  | ($chessboard[fill_0 + 2][column_0]) as $front2B
  | ($chessboard[fill_0 - 1][column_0]) as $front1W
  | ($chessboard[fill_0 - 2][column_0]) as $front2W
  | $Pawn[0] as $typeOfPawn
  | $Enemy[0] as $typeOfEnemy
  | ((fill_0 - fill_1) | fabs) as $diffOfFils
  | ((column_0 - column_1) | fabs) as $diffOfCols
  | if $diffOfCols > 1 or $diffOfFils > 2 then 
      false 
    elif ($diffOfCols == 1 and $diffOfFils == 1) and ($typeOfPawn == " ") and
     ($typeOfPawn == $typeOfEnemy) then
      false
    elif ($diffOfCols == 1 and $diffOfFils == 1) and 
    ($typeOfPawn == $typeOfEnemy) then
      false 
    elif ($diffOfCols == 1) and ($diffOfFils == 2) then
      false
    elif (($typeOfPawn == "B") and (fill_0 != 1) and ($diffOfFils > 1)) then
      false
    elif (($typeOfPawn == "B") and (fill_0 == 1) and ($diffOfFils > 2)) then
      false
    elif (($typeOfPawn == "W") and (fill_0 != 6) and ($diffOfFils > 1)) then
      false
    elif (($typeOfPawn == "W") and (fill_0 == 6) and ($diffOfFils > 2)) then
      false
    elif (($typeOfPawn == "W") and (fill_0 <= fill_1)) then
      false
    elif (($typeOfPawn == "B") and (fill_0 >= fill_1)) then
      false
    elif ($typeOfPawn == "B" and $front1B != "  " and $diffOfFils == 1) then
      false 
    elif ($typeOfPawn == "B" and $front2B != "  " and $diffOfFils == 2) then
      false
    elif ($typeOfPawn == "B" and $front1B != "  " and $diffOfFils == 2) then
      false
    elif ($typeOfPawn == "W" and $front1W != "  " and $diffOfFils == 1) then
      false 
    elif ($typeOfPawn == "W" and $front2W != "  " and $diffOfFils == 2) then
      false
    elif ($typeOfPawn == "W" and $front1W != "  " and $diffOfFils == 2) then
      false  
    else 
      true 
    end 
;

def isPawn(token):
  if token[1] == "P" then 
    true
  else
    false
  end
;

def VerifyGame(Game):
  [["BT","BC","BA","BQ","BK","BA","BC","BT"],
   ["BP","BP","BP","BP","BP","BP","BP","BP"],
   ["  ","  ","  ","  ","  ","  ","  ","  "],
   ["  ","  ","  ","  ","  ","  ","  ","  "],
   ["  ","  ","  ","  ","  ","  ","  ","  "],
   ["  ","  ","  ","  ","  ","  ","  ","  "],
   ["WP","WP","WP","WP","WP","WP","WP","WP"],
   ["WT","WC","WA","WQ","WK","WA","WC","WT"]]
  as $chessboard
  | Game as $Game
  | ($Game | length) as $size
  |  [0,$chessboard, true]
  | until
  (
    (.[0] >= 5 or .[2] == false); 
    [
      .[0] as $index
      | .[0] + 1,
      
      .[0] as $index
      | .[1] as $chessboard
      | $Game[$index] as $move 
      | $move[0] as $origin
      | $move[1] as $final
      | $origin[0] as $fill_0
      | $origin[1] as $column_0
      | $final[0] as $fill_1
      | $final[1] as $column_1
      | editChessBoard($chessboard;$fill_0;$column_0;$fill_1;$column_1),

      .[0] as $index
      | .[1] as $chessboard
      | $Game[$index] as $move 
      | $move[0] as $origin
      | $move[1] as $final
      | $origin[0] as $fill_0
      | $origin[1] as $column_0
      | $final[0] as $fill_1
      | $final[1] as $column_1
      | ($chessboard[$fill_0][$column_0] | split("")) as $token
      | if isPawn($token) then 
          verifyPeon($chessboard;$fill_0;$column_0;$fill_1;$column_1)
        else
          true
        end
    ]
  )
  |[.[0],.[2]]
;

def DivideInformation:
  [
  [
  [. 
  | split("\n") as $setOfGames
  | $setOfGames[1:-1]
  | .[] 
  | split(" ") as $game
  | $game
  ] as $Games
  | $Games 
  | .[] as $game
  | TraductionOfMoves($game)
  ] as $games 
  | $games 
  | .[] as $game
  | VerifyGame($game) as $rta
  | if $rta[1] == true then 
      "0 "
    else 
      (($rta[0] | tostring) + " ")
    end
    ]  
    | add
; 

def main:  
  if length < 1 then  empty
  else DivideInformation
  end
;

main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# 0 5 3 5 3 5 3 0 0 3 1 4 3
