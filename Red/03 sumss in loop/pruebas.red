; red -r jfgf11.red

Red[]

Sums: function [i maximum]
 [
  if i < maximum [
    numbers: input
    prin sum load numbers
    prin " "
    Sums (i + 1) maximum
  ] 
 ]

CantOfSums: load input
Sums 0 CantOfSums

; cat DATA.lst | ./red muelasvill.red
