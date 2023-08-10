def rangeArray(Numbers): 
  #range(1;RangeOfNumbers+1) as $numbers  | .[-SetOfNumbers] | indices();
  #.[-Numbers[0]:] as $SetOfNumbers | range(1;Numbers[1]+1) | indices(.[]);
  
  # Genero el arreglo con todos los N elementos del conjunto
  #.[-Numbers[0]:];

  # Genero el arrelgo del rango de numeros que contiene el conjunto 
  #[range(1;Numbers[1]+1)];

[.[-Numbers[0]:] as $SetOfNumbers 
| [range(1;Numbers[1]+1)] 
| .[] as $element 
| $SetOfNumbers 
| indices($element) | length] | join(" ");


def main:

  if length < 1 then  empty
  else rangeArray([.[0], .[1]])  #else newArray(.[0])
  end

;
main 

#cat DATA.lst | jq -r -c -s -f pruebas.jqa
#22 23 20 19 28 23 17 17 26 24 27 15 14 16 22 17