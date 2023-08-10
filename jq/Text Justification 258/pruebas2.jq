#jq -R -r -c -s -f muelasvill.jq

def lettersOfWord(word):
  [word
  | tostring
  | split("")
  | length]
  | add
;

def SummationOfWords(words):
  [words as $words
  | $words 
  | .[]
  | length]
  | add
;

def getSumation(words;index):
  [[range(index + 1)]
  | .[] as $index
  | words[$index]
  | length 
  ]  
  | add
;

def ValidBlanckspaces(blankspaces; voidspaces; cantOfwords):
  (voidspaces % blankspaces) as $mod 
  | if $mod <= 1 then
      if (voidspaces - 
      (((voidspaces / blankspaces) | floor) * blankspaces)) == 0 then 
        true
      elif (voidspaces - 
      ((((voidspaces / blankspaces) | floor) * blankspaces) + 1)) == 0 then 
        true
      else 
        false
      end  
    else 
        false
    end 
;

def verifyWords(cantOfletters;totalLetters;cantOfwords):
    cantOfletters as $cantOfletters
    | totalLetters as $totalLetters
    | cantOfwords as $cantOfwords
    | ($totalLetters - $cantOfletters) as $voidspaces
    | 1 as $blankspaces
    |[$blankspaces]
    | until (
    (ValidBlanckspaces(.[0]; $voidspaces; $cantOfwords) or (.[0] > $voidspaces)); 
    [
    .[0] as $newIndex
    | ($newIndex + 1)
    ])
    | .[0]
;

def insertBlankSpaces(line;totalLetters):
  (line | length) as $cantOfwords
  | (line | add | length) as $cantOfletters
  | ((totalLetters | tonumber) - $cantOfletters) as $voidspaces
  | [$voidspaces, $cantOfwords]
  | [1]
  | until (
    (ValidBlanckspaces(.[0]; $voidspaces; $cantOfwords) or (.[0] > $voidspaces)); 
    [
    .[0] as $newIndex
    | ($newIndex + 1)
    ])
    | .[0]
;

def getIndex(words; cantOfletters):
  words as $words
  | (cantOfletters | tonumber) as $maxOfletters
  | (words | length) as $size
  | 0 as $contLetters
  | 0 as $index  
  | [$contLetters, $index]
  | until (
    (.[0] >= $maxOfletters); 
  [
   .[0] as $newcontLetters
   | .[1] as $newindex
   | ($newcontLetters + (lettersOfWord($words[$newindex]))), 
  
  .[1] as $newIndex
  | ($newIndex + 1)
  
  ])
  | [.[0], .[1]]   
  | until (
    (((.[0] < $maxOfletters) and (($maxOfletters - .[0]) >= (.[1] - 1)))); 
  [
   .[0] as $newcontLetter
   | .[1] as $newindex
   | ($newcontLetter - (lettersOfWord($words[$newindex-1]))), 
  
  .[1] as $newIndex
  | ($newIndex - 1)
  ])
  | [.[0], .[1]] as $arrayInfo
  | $arrayInfo
  | $arrayInfo[0] as $cantOfletters 
  | $arrayInfo[1] as $cantOfwords
  | [$cantOfletters, $cantOfwords] 
  | until (
    (verifyWords($cantOfletters;$maxOfletters;$cantOfwords)); 
  [
   
   .[0] as $newcontLetter
   | .[1] as $newindex
   | ($newcontLetter - (lettersOfWord($words[$newindex-1]))), 
  
  .[1] as $newIndex
  | ($newIndex - 1)
  ])
  | .[0] as $totalChars 
  | $totalChars
  | [0]
  | until (
    getSumation($words;.[0]) == $totalChars; 
  [
   (.[0] + 1)
  ])
  | .[0]
;

def DivideWords:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[0:-1]
  | .[] 
  | split(" ") as $element 
  | $element
  ]
  | add as $words 
  | $words[0] as $maxOfletters
  | $words[1:] as $words
  #| getSumation($words;0)
  #| getIndex($words;$maxOfletters)
  | [SummationOfWords($words),0,$words,[],0]
  | until (
    .[0] < ($maxOfletters | tonumber); 
  [
   
  .[2] as $words_1
   | $words_1[getIndex($words; $maxOfletters):] as $newwords
   | SummationOfWords($newwords)
   ,
   .[2] as $words_1
    | getIndex($words_1; $maxOfletters)
   ,
   .[2] as $words_1
    | getIndex($words_1; $maxOfletters) as $newindex
    | $words_1[$newindex + 1:]
   ,
    .[2] as $words_1
    | .[3] as $lines
    | getIndex($words_1; $maxOfletters) as $newindex
    | $lines + [$words_1[:$newindex + 1]]
   ,
   .[4] + 1
  ])
  #| [.[0],.[1],.[2],.[3],.[4]]
  | [.[2],.[3]] as $lines
  | $lines[0] as $endLinne
  | $lines[1] as $bodylines 
  | $bodylines 
  | .[] as $line
  | insertBlankSpaces($line; $maxOfletters)
;

def main:
  if length < 1 then  empty
  else DivideWords
  end
;

main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# (-31 952) (63 619) (-51 -681) (87 577) (50 168) (-51 69) (47 -508)
# (-82 -912) (-32 -671) (40 -557) (22 -311) (60 -759) (74 -91) (74 832) 
