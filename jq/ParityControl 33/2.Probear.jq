 #jq -r -c -s -f melasvill.jq


def rangeArray(CantOfletters): 

[[.[-CantOfletters:] as $message  # Guardo el arreglo origninal en un variable $message
| [range(0 ; (CantOfletters-1) + 1)] # Genero todos los index de ese arreglo
| .[] as $index # Guardo el index que voy a iterar en una variable $index
| if $message[$index] != $message[-1] then  # compruebo sino esoty en la posicion 0 o n-1
  [$message[$index],""]|until(.[0] < 1; [(.[0] / 2 | floor), (.[0] % 2 | tostring) + .[1] ])| [$message[$index],.[1]] # convierto de int a bits y guardo esto en un arreglo de esta forma [int, bits] 
  else [$message[$index]] # Si es el primer indice unicamente retorne el elemento en un arreglo
  end] 
  | .[] as $bits  # Ahora urilizo la matriz de los ints y bits 
  | if ($bits | length) > 1 and ( $bits[1] | indices("1") | length) % 2 == 0 then $bits[0] #Reviso si los 1 de los bits es par
    elif ($bits | length) == 1 then $bits[0] # Si es el primer o ultimo digito significa que no es necesario comprobar
    else empty # Si no cumple las anteorires condiciones retorne null 
    end] | implode; # Implode convierte de int a chart 
  
  
def main:
  if length < 1 then  empty
  else rangeArray(length)  
  end

;
main 

#65 238 236 225 46
# cat DATA.lst | jq -r -c -s -f muelasvill.jq
