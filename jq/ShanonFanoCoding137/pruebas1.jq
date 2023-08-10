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
  | [range($start + 1; (($endd - $start) + 1))] 
  | .[] as $index
  | summation($lettersInformation[$start:$index])]
;

# En esta funcion estoy verificando en que punto debo partir el arreglo segun
# la codificacion de Shannon-Fano Coding
def splitArrays(ArraysSumsXsplitValXindexElemt):
  ArraysSumsXsplitValXindexElemt[0] as $ArraysSums
  | ArraysSumsXsplitValXindexElemt[1] as $splitVal
  | ArraysSumsXsplitValXindexElemt[2] as $indexElement
  | ($ArraysSums | length) as $size
  | [0,$ArraysSums,$splitVal]|until(.[0] >= 1; [.[0] + 1, .[1], .[2]])
  | .[0] as $splitIndex
  | if $indexElement < $splitIndex then 
    [0,$splitIndex,$splitIndex,"O"] 
    else 
    [$splitIndex,$size,($size - $splitIndex),"I"]
    end
;

def codingLetter(LettersbyappearanceXindexElement):
  LettersbyappearanceXindexElement[0] as $Lettersbyappearance
  | LettersbyappearanceXindexElement[1] as $indexElement
  | ($Lettersbyappearance | length) as $size
  | $size as $endd
  | 0 as $start
  | arraySumation([$start,$endd, $Lettersbyappearance]) as $ArraysSums
  | summation($Lettersbyappearance) as $total
  | (($total / 2) | round) as $splitVal
  | [$size,$ArraysSums,$start,$endd,$splitVal,""]
  | until( .[0] <= 1; 
  [ 

  [.[1],.[4]] as $ArrayXsplit 
  | (splitArrays([$ArrayXsplit[0], $ArrayXsplit[1], $indexElement])
   | .[2]),

  [.[2],.[3]] as $newStartEnd 
  | arraySumation([$newStartEnd[0],$newStartEnd[1], $Lettersbyappearance]),
  
  [.[1],.[4]] as $ArrayXsplit 
  | (splitArrays([$ArrayXsplit[0], $ArrayXsplit[1], $indexElement])
  | .[0]),
  
  [.[1],.[4]] as $ArrayXsplit 
  | (splitArrays([$ArrayXsplit[0], $ArrayXsplit[1], $indexElement])
  | .[1]),

  .[1] as $newArraySums 
  | (($newArraySums[-1] / 2) | round),

  [.[1],.[4],.[5]] as $ArrayXsplitXrta 
  | (splitArrays([$ArrayXsplitXrta[0], $ArrayXsplitXrta[1], $indexElement])
  | [$ArrayXsplitXrta[5] , .[3]] | add)

  ])
  | .[5]
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
  #| [range(0 ; $size)] 
  #| .[] as $index
  #| arraySumation([0,5, $lettersInformation]) as $ArraysSums
  #| splitArrays([$ArraysSums, 5, 0])
  | codingLetter([$lettersInformation,1])
;


def main:
  if length < 1 then  empty
  else coding
  end

;
main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# A5 G1 G5 F1 C#1 A3 A#2 A#5 D3 F2 F3 F#4 D2 F#3 B1 B4 F4 F#2 B3 A2
