 #jq -r -c -s -f melasvill.jq

def rangeArray(CantOfletters): 

[[[.[-CantOfletters:] as $message 
| [range(0 ; (CantOfletters-1) + 1)] 
| .[] as $index 
| if $message[$index] != $message[-1] then 
  [$message[$index],""]| 
  until(.[0] < 1; [(.[0] / 2 | floor), (.[0] % 2 | tostring) + .[1] ])
  | [$message[$index],.[1]] 
  else [$message[$index]] 
  end] 
  | .[] as $bits  
  | if ($bits | length) > 1 
  and ( $bits[1] | indices("1") | length) % 2 == 0 then $bits 
    elif ($bits | length) == 1 then $bits 
    else empty
    end] | .[] as $message  
    | if ($message | length) == 1 then $message[0] 
    elif ( $message[0] > 64 and $message[0] < 91 )   
    or ( $message[0] >  96 and $message[0] < 123 )
    or ( $message[0] >  47 and $message[0] < 58 )
    or ( $message[0] ==  32 ) then $message[0] 
    else $message[0] - 128 
    end] | implode;  
  
def power(index):
  index as $index
  | if $index > 0 then
  [1, 1] 
  | until(.[0] > $index; 
  [
  .[0] + 1, 
  
  .[1] * 2
  ])
  |.[1]
  else                                                  
  1
  end 
;


def bitsToNumber(bits):
  bits
  | split("")
  | reverse as $organizedBits
  | ($organizedBits | length) as $size
  | 0 as $total
  | 0 as $index
  | [$index,$total]
  | until(.[0] >= $size;
  [
  .[0] + 1, 
  .[0] as $newindex
  | if ($organizedBits[$newindex] == "I") then
    .[1] + (power($newindex))
  else
    .[1]
  end
  ])
  |.[1]
;

def main:
  if length < 1 then  empty
  else rangeArray(length)  
  end

;
main 

# cat DATA.lst | jq -r -c -s -f muelasvill.jq
#G5JFXb SD 8kALVbSLOSZDWj92vn6I QB3Enxigmk rF xkuDLpt Tdzq iQBud4SoucibX4j.
