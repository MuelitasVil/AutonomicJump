 #jq -r -c -s -f melasvill.jq

# Esta funcionva a verificar si los indices estan en la lista de los numeros que se que no van en esa posicion
# Es decir si el 7 es posible numero pero luego en un intetno me doy cuenta que no iba en esa poscion lo descarto en 
# donde aparezca.

#def checkPosition(possibleNumbers):
 #(possibleNumbers | length) as $size #Reviso el tamaño del arreglo
    #| [1,2,3,4]
    #| .[] as $num
    #| [range(0 ; ($size-1) + 1)] # saco los indices del arreglo
    #| .[] as $index # Agarro el indice
    #| possibleNumbers[$index] as $element
    #| $element; # Saco el elemento del indice



def CompleteGoodNymbers(goodNumbers):
    ((if goodNumbers[0][2] != null then goodNumbers[0][2] | tostring else "5"  end) 
    + (if goodNumbers[1][2] != null then goodNumbers[1][2] | tostring else "5" end) 
    + (if goodNumbers[2][2] != null then goodNumbers[2][2] | tostring else "5" end) 
    + (if goodNumbers[3][2] != null then goodNumbers[3][2] | tostring else "5" end) | split("")) as $CorrectPosition
    | ["0","1","2","3"] 
    | .[];
    
def discardGoodNumbers(information):
  information[0] as $matriz
  | information[1] as $goodNumbers
  | $goodNumbers;
   

#En esta funcion voy a recorrer una matriz ya habiendo eliminado los bad numbers de cada fila de posicion de numeros
# Voy a revisar los numeros que se que es el correcto donde sea la unica posibilidad (ver paint)

def uniqueNumberIntried(matrizOfNumbers):  
  matrizOfNumbers as $matriz # Verifico la cantidad de columnas qu tiene la matriz 
  |($matriz[0] | length) as $size
  | [range(0 ; ($size - 1) + 1)]
  | .[] as $index # Itero los indices
  | [$matriz[0][$index][0],$matriz[1][$index][0],
    $matriz[2][$index][0],$matriz[3][$index][0]] as $InfoNumber # Agrupo la posibilidad de un numero ser el correcto de cada posicion
  | (($InfoNumber | indices(1))) as $PosibleNumbers
  | if (($PosibleNumbers | length) == 1) then 
   [$index,$matriz[$PosibleNumbers[0]][$index][1],$matriz[$PosibleNumbers[0]][$index][2]]
   else empty
   end;


def uniqueNumberPos(possibleNumbers):
    DeletePosition(possibleNumbers)
    | unique  # Ahora solo tengo el numero y si este puede ser una respuesta
    | add as $PosibleAndNumber
    | $PosibleAndNumber # Uno toda esta informacion a un solo arreglo
    | indices(1) as $CantNumbers
    | if (($CantNumbers  | unique) | length ) == 1 then ($PosibleAndNumber[$CantNumbers[0]+1] | tostring) else "-" end; # Verifico cuantos numeros puede ir en esa posicion si solo es uno retornelo

def discardBadNumbers(information):
  [information[0] as $attemptsbyPosition
  | information[1] as $badNumbers
  | $badNumbers
  | ($attemptsbyPosition | length) as $size
  | [range(0 ; ($size - 1) + 1)]
  | .[] as $index
  | $attemptsbyPosition[$index]
  | [.[]] as $element
  | if ($badNumbers | indices($element[1]) | length) > 0 
    then [0, $element[1], $element[2]] 
    else  $element
    end];

def DeletePosition(possibleNumbers): # Elimino la posicion 3 de mi informacion
    [possibleNumbers | .[] | del(.[2])]; # Es este lugar indico a que posicion pertenecia el numero

# La idea de esta funcion es sacar una lista de los numeros que no van en esa posicion
def badNumbers(attemptByPosition):
  [(attemptByPosition | length) as $size #Reviso el tamaño del arreglo
    | [range(0 ; ($size - 1) + 1)] # saco los indices del arreglo
    | .[] as $index # Agarro el indice
    | attemptByPosition[$index] as $element # Saco el elemento del indice
    | if $element[0] == 0 then $element[1] else empty end] # Compruebo si este numero es correcto o no e imrpimo su lista
    ;
      
def guessNumber(CantOftrys): 
[[[[[[.[-CantOftrys - 1:] as $message 
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
      | [range(0 ; ($size - 1) + 1)]  # Genero un rango de numeros del tamaño de la cantidad de numero  
      | [.[] as $index # Itero los indices de la lista de numeros
      | $Attempts[$index] as $tried # Agarro el intento de esa posicion
      | ($tried[0] | split("")) as $number # divido el numero para poder acceder a sus numeros
      | if $tried[1] == "1" then ([1,$number[$num], $num ]) # Si existe un numero correcto en el intento lo agrupo con un 1 al inicio
       else ([0,$number[$num], $num]) end]] # De lo contrario ingreso un 0 al incio
      | .[] as $attemptByPosition
      | $attemptByPosition
      | (badNumbers($attemptByPosition) | unique) as $badNumbers
      | $badNumbers 
      | discardBadNumbers([$attemptByPosition, $badNumbers])] 
      | . as $matrizOfNumbers
      | ([uniqueNumberIntried($matrizOfNumbers)] | add) as $firstNumbers
      | [[$firstNumbers| getpath([0],[1],[2])], 
      [$firstNumbers | getpath([3],[4],[5])],
      [$firstNumbers | getpath([6],[7],[8])],
      [$firstNumbers | getpath([9],[10],[11])]];
      #| ($firstNumbers | length) as $sizeFN
      #| [range(0 ; ($sizeFN - 1) + 1)]
      #| .[] as $indexFN 
      #| $firstNumbers[$indexFN] as $correctNumber 
      #| ($matrizOfNumbers[0] | length) as $sizematriz
      #| [range(0 ; ($sizematriz - 1) + 1)]
      #| .[] as $indexmatriz
      #| if $indexmatriz != $correctNumber[1] then 
      #  [0, $matrizOfNumbers[$correctNumber[2]][$indexmatriz][1],$matrizOfNumbers[$correctNumber[2]][$indexmatriz][2]]  
      #   else $matrizOfNumbers[$correctNumber[2]] end;
      
       

      #| discardBadNumbers([$possibleNumbers, $firstNumbers]) as $newpossibleNumbers;
      # [uniqueNumber($newpossibleNumbers)] as $secondNumbers
      #| $secondNumbers;
      #| ($possibleNumbers | length) as $size
      #| [range(0 ; ($size-1) + 1)] # saco los indices del arreglo
      #| .[] as $index # Agarro el indice
      #| $index; #| $possibleNumbers[$position];

       
       #| ($possibleNumbers | length) as $size
       #| [range(0 ; ($size-1) + 1)]
       #| .[] as $index
       #| $possibleNumbers[$index];
    

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
