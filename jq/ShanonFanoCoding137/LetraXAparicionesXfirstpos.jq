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
    ;

def codingByLetter(indexXsize):
    if indexXsize[0] < (indexXsize[1] - 1) 
    then 
    [indexXsize[0],"O"]|until(.[0] < 1; [.[0] - 1, "I"+.[1]])|.[1] 
    else
    [indexXsize[0] - 1,"I"]|until(.[0] < 1; [.[0] - 1, "I"+.[1]])|.[1]
    end
    ;


def coding: 
    splitSentence(.) as $sentence
    | ($sentence) as $asciiSentence
    | ($asciiSentence  | unique ) as $letters
    | countLetters([$asciiSentence, $letters]) as $Lettersbyappearance
    | $Lettersbyappearance 
    
;    
    
def main:
  if length < 1 then  empty
  else coding
  end
;

main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# A5 G1 G5 F1 C#1 A3 A#2 A#5 D3 F2 F3 F#4 D2 F#3 B1 B4 F4 F#2 B3 A2
