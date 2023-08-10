#jq -r -c -s -f melasvill.jq

def rangeArray(CantOfFrequencies): 

[.[-CantOfFrequencies:] as $SetOfNumbers 
| { 
    "1" : "C",  "2" : "C#", "3" : "D", "4" : "D#",
    "5" : "E", "6" : "F", "7" : "F#", "8" : "G",
    "9" : "G#",  "10" : "A", "11" : "A#", "0" : "B"
  } as $DictionaryOfNotes
| $SetOfNumbers
| .[] as $frecuency
| (((($frecuency / 16.352) | log2 | . * 12) | round) + 1) as $Distance
| (($Distance % 12) | tostring) as $Note
| (((($Distance / 13) | floor)) | tostring) as $numberOctave
| ([$DictionaryOfNotes[$Note],$numberOctave," "] | add)] | add
;


def main:
  if length < 1 then  empty
  else rangeArray(.[0])  
  end

;
main 

# cat DATA.lst | jq -r -c -s -f muelasvill.jq
# A5 G1 G5 F1 C#1 A3 A#2 A#5 D3 F2 F3 F#4 D2 F#3 B1 B4 F4 F#2 B3 A2
