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

def getWords(words;index):
  [range(index)
  | .[] as $index
  | words[$index] 
  ]
;

def verifyWords(cantOfletters;totalLetters;cantOfwords):
    cantOfletters as $cantOfletters
    | totalLetters as $totalLetters
    | cantOfwords as $cantOfwords
    | ($totalLetters - $cantOfletters) as $voidspaces
    | 1 as $blankspaces
    |[$blankspaces]
    | until (
    ((($voidspaces / .[0]) | floor) == ($cantOfwords - 1) or (.[0] > $voidspaces)); 
    [
    .[0] as $newIndex
    | ($newIndex + 1)
    ])
    | if (($voidspaces / .[0]) | floor) == ($cantOfwords - 1) then 
      true
      else 
      false
      end 
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
  | (.[1])
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
  | getIndex($words; $maxOfletters)
  | $words
  | [SummationOfWords($words),$words,0]
  | until (
    .[2] > 0; 
  [
  
    .[1] as $words_1
   | $words_1[getIndex($words; $maxOfletters):] as $newwords
   | SummationOfWords($newwords)
   ,
   .[1] as $words_1
    | $words_1[getIndex($words; $maxOfletters):] as $words
    | $words
   ,
   .[2] + 1
  ])
  | [.[0],.[1],.[2]]
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