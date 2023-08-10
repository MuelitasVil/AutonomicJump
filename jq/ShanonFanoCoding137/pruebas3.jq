 #jq -r -c -s -f melasvill.jq

def countLetters(sentenceXletters):
  sentenceXletters[0] as $asciiSentence
  | sentenceXletters[1] as $letters
  | $letters
  | .[] as $letter
  | $asciiSentence 
  | [$letter,(indices($letter) | length), index($letter)] 
; 

def splitSentence(sentence):
  (sentence | split("")) as $sentence
  | $sentence 
  | length as $tam
  | $tam
  | $sentence
  | del(.[$tam - 1])
  | add    
;

def getappearances(lettersInformation):
  lettersInformation 
  | .[] as $element
  | $element[1] 
;

def summation(lettersInformation):
  [getappearances(lettersInformation)]
  | .
  | add
;

# Genero el arreglo con las sumtoria correspondiente a cada indice
def arraySumation(startXendXlettersInformation):
  [startXendXlettersInformation[0] as $start
  | startXendXlettersInformation[1] as $endd
  | startXendXlettersInformation[2] as $lettersInformation
  | [range($start + 1; (($endd) + 1))] 
  | .[] as $index
  | summation($lettersInformation[$start:$index])]
;

# En esta funcion estoy verificando en que punto debo partir el arreglo segun
# la codificacion de Shannon-Fano Coding
def splitArrays(ArraysSumsXsplitValXindexElemtXStartXend):
  ArraysSumsXsplitValXindexElemtXStartXend[0] as $ArraysSums
  | ArraysSumsXsplitValXindexElemtXStartXend[1] as $splitVal
  | ArraysSumsXsplitValXindexElemtXStartXend[2] as $indexElement
  | ArraysSumsXsplitValXindexElemtXStartXend[3] as $start
  | ArraysSumsXsplitValXindexElemtXStartXend[4] as $endd
  | ($ArraysSums | length) as $size
  | [$start]|until($ArraysSums[.[0]] >= $splitVal; [.[0] + 1])
  | (.[0] + 1) as $splitIndex 
  | if $indexElement < $splitIndex and $size != 2 then 
    [$start,$splitIndex,"O",$splitIndex-$start] 
    elif $indexElement >= $splitIndex and $size != 2 then
    [$splitIndex,$size,"I",($size - $splitIndex)]
    elif $indexElement == 0 then
    [0,0,"O",0]
    else
    [0,0,"I",0]
    end
;

def codingLetter(LettersbyappearanceXindexElement):
  LettersbyappearanceXindexElement[0] as $Lettersbyappearance
  | LettersbyappearanceXindexElement[1] as $indexElement
  | ($Lettersbyappearance | length) as $size
  | $size as $endd
  | 0 as $start
  | arraySumation([$start,$endd, $Lettersbyappearance, 0]) as $ArraysSums
  | $ArraysSums[-1] as $total
  | (($total / 2) | round) as $splitVal
  | [$size,$ArraysSums,$start,$endd,$splitVal,"",0,$Lettersbyappearance]
  | until( .[6] > 0; 
  [ 
  #size 0
  .[1] as $newArraySums 
  | .[2] as $newStart
  | .[3] as $newEnd
  | .[4] as $newSplitVal
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd]) 
  | .[3]),
  #Array 1
  [.[1] as $newArraySums 
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[0]) as $newStart
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[1] )as $newEnd
  | .[5] as $newIndexElement
  | .[7] as $newLettersbyAppearance
  | [range(0 ; $size)] 
  | .[] as $index
  | $newLettersbyAppearance[$index] as $element
  | if $index < $newStart then
    [$element[0],0,$element[1]]
    else
    $element
    end] as $newLettersbyAppearance
  |.[2] as $newStart 
  | arraySumation([0,$size,$newLettersbyAppearance,$newStart,$newEnd]),
  #Start 2
  .[1] as $newArraySums 
  | .[2] as $newStart
  | .[3] as $newEnd
  | .[4] as $newSplitVal
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[0]),
  #End 3
  .[1] as $newArraySums
  | .[2] as $newStart 
  | .[3] as $newEnd
  | .[4] as $newSplitVal
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[1]),
  #splitval 4
  .[2] as $newStart 
  | .[7] as $newLettersbyAppearance
  | arraySumation([0,$size,$newLettersbyAppearance,$newStart,$newEnd]) as $array
  | ($array[-1] / 2 | round)
  ,
  #RTA 5
  .[1] as $newArraySums
  | .[2] as $newStart
  | .[3] as $newEnd
  | .[4] as $newSplitVal
  | .[5] as $rta
  |(splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | [$rta, .[2]] | add),
  #Cont 6
  .[6] + 1,
  #$newLettersbyAppearance 7
  [.[1] as $newArraySums 
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[0]) as $newStart
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[1] )as $newEnd
  | .[5] as $newIndexElement
  | .[7] as $newLettersbyAppearance
  | [range(0 ; $size)] 
  | .[] as $index
  | $newLettersbyAppearance[$index] as $element
  | if $index < $newStart then
    [$element[0],0,$element[1]]
    else
    $element
    end]
  
  ])
  | [.[0],.[1],.[2],.[3],.[4],.[5],.[6],.[7]]
  #| [.[8],.[6]] as $ArrayXrta
  #| $ArrayXrta[0] as $array
  #| $ArrayXrta[1] as $rta
  #| $Lettersbyappearance[$indexElement][0] as $letter
  #| if($array[0][0] == $letter) then
  #$rta + "O"
  #else 
  #$rta + "I"
  #end
;

def shortInformation(Lettersbyappearance):
  [Lettersbyappearance 
  | group_by(.[1]) 
  | reverse
  | .[] as $groupAppearance
  | ($groupAppearance | sort_by(.[0]))
  | .[]]
;

def coding: 
  [splitSentence(.) as $sentence
  | {} as $diccionari
  | ($sentence | explode) as $asciiSentence
  | ($asciiSentence | unique) as $letters
  | countLetters([$asciiSentence, $letters])] as $Lettersbyappearance
  | $Lettersbyappearance 
  | sort_by(.[2]) as $lettersInformation 
  | ($lettersInformation | length) as $size
  | shortInformation($Lettersbyappearance) as $ordenLetters
  #| [range(0 ; $size)] 
  #| .[] as $index
  | [$ordenLetters[0][0], codingLetter([$ordenLetters,3])]
  #| arraySumation([0,$size, $ordenLetters]) as $ArraysSums
  #| $ArraysSums[-1] / 2 | round as $split 
  #| splitArrays([$ArraysSums,$split, 2,0])  as $info
  #| $info
  #| arraySumation([$info[0],$info[1], $ordenLetters]) as $newArray
  #| $newArray
  #| ($newArray[-1] / 2) | round as $newsplit
  #| $info[3] as $newIndex
  #| splitArrays([$newArray,$newsplit, $newIndex]) as $info2
  #| arraySumation([$info2[0],$info2[1], $ordenLetters]) as $newArray2
  #| $newArray2
  #| ($newArray2[-1] / 2) | round as $newsplit2
  #| $info2[3] as $newIndex2
  #| splitArrays([$newArray2,$newsplit2, $newIndex2]) as $info3
  #| $info3
  #| [$info, $info2]
;


def main:
  if length < 1 then  empty
  else coding
  end

;
main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# A5 G1 G5 F1 C#1 A3 A#2 A#5 D3 F2 F3 F#4 D2 F#3 B1 B4 F4 F#2 B3 A2
