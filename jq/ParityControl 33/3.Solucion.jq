 #jq -r -c -s -f melasvill.jq


def rangeArray(CantOfletters): 

[[[.[-CantOfletters:] as $message  # Guardo el arreglo origninal en un variable $message
| [range(0 ; (CantOfletters-1) + 1)] # Genero todos los index de ese arreglo
| .[] as $index # Guardo el index que voy a iterar en una variable $index
| if $message[$index] != $message[-1] then  # compruebo sino esoty en la posicion 0 o n-1
  [$message[$index],""]|until(.[0] < 1; [(.[0] / 2 | floor), (.[0] % 2 | tostring) + .[1] ])| [$message[$index],.[1]] # convierto de int a bits y guardo esto en un arreglo de esta forma [int, bits] 
  else [$message[$index]] # Si es el primer indice unicamente retorne el elemento en un arreglo
  end] 
  | .[] as $bits  # Ahora urilizo la matriz de los ints y bits 
  | if ($bits | length) > 1 and ( $bits[1] | indices("1") | length) % 2 == 0 then $bits #Reviso si los 1 de los bits es par
    elif ($bits | length) == 1 then $bits # Si es el primer o ultimo digito significa que no es necesario comprobar
    else empty # Si no cumple las anteorires condiciones retorne empty
    end] | .[] as $message  # Ahora recorro la lista de bits que cumplieron la paridad
    | if ($message | length) == 1 then $message[0] # Compruebo que sean un caracter o un numero 
    elif ( $message[0] > 64 and $message[0] < 91 )   
    or ( $message[0] >  96 and $message[0] < 123 )
    or ( $message[0] >  47 and $message[0] < 58 )
    or ( $message[0] ==  32 ) then $message[0] 
    else $message[0] - 128 # Si no se cumple esto les quito el bit extra y listo
    end] | implode;  
  
  # Notas : me aprovecho que aunque el 8 bit siempre vale 128 y que no importa como rellene los bits
  # Porque no importa donde agrege el bit no va a cambiar la cantidad de 1's
  
def main:
  if length < 1 then  empty
  else rangeArray(length)  
  end

;
main 

#65 238 236 225 46
# cat DATA.lst | jq -r -c -s -f muelasvill.jq
