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
  | if $mod <= 1  then
      if (((voidspaces / blankspaces) | floor) == (cantOfwords - 1)) then 
        true
      elif ((((voidspaces / blankspaces) | floor) + 1)
      == (cantOfwords - 1)) then 
        true
      elif (((((voidspaces - 1) / blankspaces) | floor) + 1)
      == (cantOfwords - 1)) then 
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
    | 2 as $blankspaces
    | if ($voidspaces  == ($cantOfwords - 1)) or 
      (($voidspaces  == $cantOfwords)) then 
        true
      else  
        [$blankspaces]
        | until (
        (ValidBlanckspaces(.[0]; $voidspaces; $cantOfwords) or
        (.[0] > $voidspaces)); 
      [
      .[0] as $newIndex
      | ($newIndex + 1)
      ])
      | ValidBlanckspaces(.[0]; $voidspaces; $cantOfwords)
    end 
;

def getVoidSpaces(cantOfletters;totalLetters;cantOfwords):
    cantOfletters as $cantOfletters
    | totalLetters as $totalLetters
    | cantOfwords as $cantOfwords
    | ($totalLetters - $cantOfletters) as $voidspaces
    | 2 as $blankspaces
    | if ($voidspaces  == ($cantOfwords - 1)) or 
      (($voidspaces  == $cantOfwords)) then 
      true
    else  
      [$blankspaces]
      | until (
      (ValidBlanckspaces(.[0]; $voidspaces; $cantOfwords) or 
      (.[0] > $voidspaces)); 
      [
      .[0] as $newIndex
      | ($newIndex + 1)
      ])
      | .[0]
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
    (((.[0] <= $maxOfletters) and (($maxOfletters - .[0]) >= (.[1] - 1)))); 
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

def deleteIndex(word; deletein):
  word
  | del(.[deletein
  | .[]])
;

def printLine1(words):
  [words
  | .[] + " "] 
  | add
;

def printLine2(words):
  [
  (words | length) as $size
  | [range($size)]
  | .[] as $i
  | $i
  | if $i != 0 then
   words[$i] + " "
   else 
   words[$i] + "  "
   end
   ] 
  | add
;

def printLine3(words;totalLetters;cantOfletters):
  (totalLetters - cantOfletters) as $voidSpaces
  | if ($voidSpaces % 2) != 0 then
    [words[0],
    (" " * (($voidSpaces / 2) | round)),
    words[1],
    (" " * (($voidSpaces / 2) | floor)),
    words[2]]
   else 
    [words[0],
    (" " * ($voidSpaces / 2)),
    words[1],
    (" " * ($voidSpaces / 2)),
    words[2]]
    end
    | add
;

def printLine4(words;totalLetters;cantOfletters;blankspaces):
  if ((totalLetters - cantOfletters) % blankspaces) == 0 then  
    [ 
    (words | length) as $size
    | [range($size)] 
    | .[] as $index
    | if $index != ($size - 1) then
      words[$index] + (" "  * blankspaces)
      else 
      words[$index]
      end
    ]
    | add
  else
    [ 
    (words | length) as $size
    | [range($size)] 
    | .[] as $index
    | if $index != ($size - 1) and $index != 0 then
      words[$index] + (" "  * blankspaces)
      else 
      words[$index] + " "
      end
    ]
    | add
  end  
;

def insertBlankSpaces(line;totalLetters):
  (line | length) as $cantOfwords
  | (line | add | length) as $cantOfletters
  | if $cantOfletters == totalLetters then
    printLine1(line)
  elif $cantOfwords == 2 then
    [line[0],(" " * (totalLetters - $cantOfletters)),line[1]] 
    | add
  elif (totalLetters - $cantOfletters) == ($cantOfwords - 1) then
    printLine1(line)
  elif (totalLetters - $cantOfletters) == ($cantOfwords) then
    printLine2(line)
  elif ($cantOfwords) == 3 then
    printLine3(line;totalLetters;$cantOfletters)
  else 
    getVoidSpaces($cantOfletters;totalLetters;$cantOfwords) as $blankspaces
    | printLine4(line;totalLetters;$cantOfletters;$blankspaces)
  end
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
  | [SummationOfWords($words),0,$words,[],0]
  | until (
    .[0] < ($maxOfletters | tonumber); 
  [
   
  .[2] as $words_1
   | $words_1[getIndex($words_1; $maxOfletters):] as $newwords
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
  | [.[0],.[1],.[2],.[3],.[4]]
  | [.[2],.[3]] as $lines
  | $lines[0] as $endLine
  | $lines[1] as $bodylines 
  | ($bodylines + [$endLine]) as $lines
  | ($lines | length) as $size
  | [(range($size))] 
  | .[] as $index  
  | if ($index != ($size - 1)) then
  insertBlankSpaces($lines[$index];$maxOfletters | tonumber)
  else 
  printLine1($lines[$index])
  end
;

def main:
  if length < 1 then  empty
  else DivideWords
  end
;

main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# "When       Mrs.
# Turner       has
# brought  in  the
# tray I will make
# it clear to you.
# Now," he said as
# he        turned
# hungrily  on the
# simple fare that
# our landlady had
# provided,     "I
# must  discuss it
# while I eat, for
# I  have not much
# time.    It   is
# nearly five now.
# In  two hours we
# must be  on  the
# scene of action.
# Miss  Irene,  or
# Madame,  rather,
# returns from her
# drive  at seven.
# We  must  be  at
# Briony  Lodge to
# meet her."
