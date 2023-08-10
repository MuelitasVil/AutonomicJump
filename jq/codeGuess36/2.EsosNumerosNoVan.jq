 #jq -r -c -s -f melasvill.jq

# En este codigo saco los numeros que no van en su respectiva posicion

# La idea de esta funcion es sacar una lista de
def badNumbers(attemptByPosition):
  [(attemptByPosition | length) as $size #Reviso el tamaño del arreglo
    | [range(0 ; ($size-1) + 1)] # saco los indices del arreglo
    | .[] as $index # Agarro el indice
    | attemptByPosition[$index] as $element # Saco el elemento del indice
    | if $element[0] == 0 then $element[1] else empty end] # Compruebo si este numero es correcto o no e imrpimo su lista
    ;
      
def guessNumber(CantOftrys): 
[[[[[.[-CantOftrys-1:] as $message 
| [range(1 ; (CantOftrys / 2 | floor) + 1)] # Teniendo en cuenta que son n pares divido el rango en 2
| .[] as $index # Genero un string de el primer y el segundo elemento de los pares
|  ($message[($index * 2) - 1] | tostring) +"_"+($message[$index * 2] | tostring)+"-"
] # Generar una matriz de los datos
 | add | split("-")
 | .[] | split("_")] 
  | .[] as $pares 
  | if (($pares | length) >  1) then $pares # eliminar el string vacio al final de _
    else empty
    end] 
    | .[] as $tried  # Rellenar los caracteres 
    | $tried[0] as $nums # Difino el numero como nums
    | if (($nums | length) == 1) then [(["000", $nums] | add), $tried[1]] # Compruebo que tamaño tiene cada numero 
      elif (($nums | length) == 2) then [(["00", $nums] | add), $tried[1]] # Se agregan los 0 correspondientes 
      elif (($nums | length) == 3) then [(["0", $nums] | add), $tried[1]]
      else [$nums, $tried[1]]
      end] 
      | . as $Attempts # llamo la las listas 
      | ($Attempts | length) as $size # Reviso cuantos numeros hay
      #| [["a","a","a","a"],["","","",""]] as $information
      | [0, 1, 2, 3] # Debido a que se que hay 4 numeros en el numero
      | .[] as $num # Recorro esos 4 numeros todos los numeros
      | [range(0 ; ($size-1) + 1)]  # Genero un rango de numeros del tamaño de la cantidad de numero  
      | [.[] as $index # Itero los indices de la lista de numeros
      | $Attempts[$index] as $tried # Agarro el intento de esa posicion
      | ($tried[0] | split("")) as $number # divido el numero para poder acceder a sus numeros
      | if $tried[1] == "1" then ([1,$number[$num], $num ]) # Si existe un numero correcto en el intento lo agrupo con un 1 al inicio
       else ([0,$number[$num], $num]) end]] # De lo contrario ingreso un 0 al incio
       | .[] as $attemptByPosition
       | $attemptByPosition 
       | badNumbers($attemptByPosition) ;
    

       #  .[3] += 1) | .[1];   

          # Talvez podria utilizar until para recorrer el array
          # [arreglo, indice]
          # Mañana prooar si puedo imitar un doble for en el arreglo 

        

def main:
  if length < 1 then  empty
  else guessNumber(length)  
  end

;
main 

#65 238 236 225 46
# cat DATA.lst | jq -r -c -s -f muelasvill.jq
