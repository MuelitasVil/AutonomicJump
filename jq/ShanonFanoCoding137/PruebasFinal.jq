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

def checkIndex(indexXelementXsplit):
  indexXelementXsplit[0] as $index
  | indexXelementXsplit[1] as $element
  | indexXelementXsplit[2] as $elementbefore
  | indexXelementXsplit[3] as $split
  | (($split - $element) | fabs) as $Probability1
  | (($split - $elementbefore) | fabs) as $Probability2
  | if $Probability1 == 0 then
    $index - 1 
    elif $Probability2 < $Probability1 then  
    $index - 1
    else
    $index
    end   
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
  | [$start]|until($ArraysSums[.[0]] > $splitVal; [.[0] + 1])
  | .[] as $Index 
  | checkIndex([$Index, $ArraysSums[$Index],$ArraysSums[$Index-1],$splitVal]) as $splitIndex  
  | if $indexElement <= $splitIndex and $size != 2 then 
    [$start,$splitIndex + 1,"O",$splitIndex - $start + 1] 
    elif $indexElement > $splitIndex and $size != 2 then
    [$splitIndex + 1,$endd,"I",$endd - ($splitIndex + 1)]
    elif $indexElement == 0 then
    [0,0,"O",0]
    else
    [0,0,"I",0]
    end
;

def shortInformation(Lettersbyappearance):
  [Lettersbyappearance 
  | group_by(.[1]) 
  | reverse
  | .[] as $groupAppearance
  | ($groupAppearance | sort_by(.[0]))
  | .[]]
;

def power(index):
  index as $index
  | if $index > 0 then
  [1, 1] 
  | until(.[0] > $index; 
  [
  .[0] + 1, 
  
  .[1] * 2
  ])
  |.[1]
  else                                                  
  1
  end 
;

def bitsToNumber(bits):
  bits
  | split("")
  | reverse as $organizedBits
  | ($organizedBits | length) as $size
  | 0 as $total
  | 0 as $index
  | [$index,$total]
  | until(.[0] >= $size;
  [
  .[0] + 1, 
  .[0] as $newindex
  | if ($organizedBits[$newindex] == "I") then
    .[1] + (power($newindex))
  else
    .[1]
  end
  ])
  |.[1]
;

def codingLetter(LettersbyappearanceXindexElement):
  LettersbyappearanceXindexElement[0] as $Lettersbyappearance
  | LettersbyappearanceXindexElement[1] as $indexElement
  | ($Lettersbyappearance | length) as $size
  | $size as $endd
  | 0 as $start
  | arraySumation([$start,$endd, $Lettersbyappearance, 0]) as $ArraysSums
  | $ArraysSums[-1] as $total
  | (($total / 2) | floor) as $splitVal
  | [$size,[$ArraysSums,$splitVal],$start,$endd,"",0,$Lettersbyappearance]
  | until( .[0] <= 2; 
  [ 
  #size 0
  .[1][0] as $newArraySums 
  | .[2] as $newStart
  | .[3] as $newEnd
  | .[1][1] as $newSplitVal
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[3]),
  #Array 1
  [.[1][0] as $newArraySums 
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[0]) as $newStart
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[1] )as $newEnd
  | .[4] as $newIndexElement
  | .[6] as $newLettersbyAppearance
  | [range(0 ; $size)] 
  | .[] as $index
  | $newLettersbyAppearance[$index] as $element
  | if $index < $newStart  then
    [$element[0],0,$element[1]]
    elif $index > $newEnd - 1 then
    [$element[0],0,$element[1]]
    else
    $element
    end] as $newLettersbyAppearance
  |.[2] as $newStart 
  | [arraySumation([0,$size,$newLettersbyAppearance,$newStart,$newEnd]),
  (arraySumation([0,$size,$newLettersbyAppearance,$newStart,$newEnd]) | (.[-1] / 2) | floor)]
  ,
  #Start 2
  .[1][0] as $newArraySums 
  | .[2] as $newStart
  | .[3] as $newEnd
  | .[1][1] as $newSplitVal
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[0]),
  #End 3
  .[1][0] as $newArraySums
  | .[2] as $newStart 
  | .[3] as $newEnd
  | .[1][1] as $newSplitVal
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[1]),
  #RTA 4
  .[1][0] as $newArraySums
  | .[2] as $newStart
  | .[3] as $newEnd
  | .[1][1] as $newSplitVal
  | .[4] as $rta
  |(splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | [$rta, .[2]] | add),
  #Cont 5
  .[5] + 1,
  #$newLettersbyAppearance 6
  [.[1][0] as $newArraySums 
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[0]) as $newStart
  | (splitArrays([$newArraySums, $newSplitVal, $indexElement,$newStart,$newEnd])
  | .[1] )as $newEnd
  | .[4] as $newIndexElement
  | .[6] as $newLettersbyAppearance
  | [range(0 ; $size)] 
  | .[] as $index
  | $newLettersbyAppearance[$index] as $element
  | if $index < $newStart then
    [$element[0],0,$element[1]]
    elif $index > $newEnd - 1 then
    [$element[0],0,$element[1]]
    else
    $element
    end]
  
  ])
  #| [.[0],.[1],.[2],.[3],.[4],.[5],.[6]]
  | [.[0],.[2],.[3],.[4]] as $Info
  | $Info[0] as $size
  | $Lettersbyappearance[$Info[1]][0] as $left
  | $Lettersbyappearance[$Info[2]-1][0] as $right
  | $Lettersbyappearance[$indexElement][0] as $letter
  | $Info[3] as $rta 
  | if $left == $letter and $size > 1 then
  $rta + "O"
  elif $right == $letter and $size > 1 then
  $rta + "I"
  else
  $rta
  end
;

def coding: 
  [[[[splitSentence(.) as $sentence
  | {} as $diccionari
  | ($sentence | explode) as $asciiSentence
  | ($asciiSentence | unique) as $letters
  | countLetters([$asciiSentence, $letters])] as $Lettersbyappearance
  | $Lettersbyappearance 
  | sort_by(.[2]) as $lettersInformation 
  | ($lettersInformation | length) as $size
  | shortInformation($Lettersbyappearance) as $ordenLetters
  | [range(0 ; $size)] 
  | .[] as $index
  | [$ordenLetters[$index][0], codingLetter([$ordenLetters,$index])]]
  | . as $rta
  | $rta 
  |  sort_by(.[0])
  | .[] as $element
  | [($element[0] | tostring),$element[1],(bitsToNumber($element[1] | tostring))]]
  | sort_by(.[2]) 
  | .[] as $element
  | [$element[0] | tostring," ",$element[1]," "]]
  | add | add
;

# Pasa ABRACADABRA
# y pasa ANITALAVALATINA

def main:
  if length < 1 then  empty
  else coding
  end

;
main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# A5 G1 G5 F1 C#1 A3 A#2 A#5 D3 F2 F3 F#4 D2 F#3 B1 B4 F4 F#2 B3 A2
