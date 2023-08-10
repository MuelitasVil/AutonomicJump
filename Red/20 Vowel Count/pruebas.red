; red -r jfgf11.red

Red[]

GetCantOfVowel: function [i cantOfLetters cantOfVowel word]
 [
  letter: pick word i
  if (letter == #"a") or (letter == #"e") or (letter == #"i")
    or (letter == #"o") or (letter == #"u") or (letter == #"y")
    [
      cantOfVowel: cantOfVowel + 1 
    ] 

  if i <= cantOfLetters [
    GetCantOfVowel (i + 1) cantOfLetters cantOfVowel word
  ] 

  if i > cantOfLetters [
    prin cantOfVowel 
    prin " "
  ]
 ]


VowelCount: function [i cantOfWords]
 [
  if i < cantOfWords [
    word: input
    cantOfLetters: length? word
    GetCantOfVowel 1 cantOfLetters 0 word
    VowelCount (i + 1) cantOfWords
  ]
 ]

CantOfWords: load input
VowelCount 0 cantOfWords

; cat DATA.lst | ./red muelasvill.red
