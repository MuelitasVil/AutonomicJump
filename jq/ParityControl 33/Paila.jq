 #jq -r -c -s -f melasvill.jq


def rangeArray(CantOfletters): 
.[-CantOfletters:] as $message 
| [range(0 ; (CantOfletters-1) + 1)]
| .[] as $index
| if $index != 0 and $message[$index] != $message[-1] and (
    ( $message[$index]  - 128 > 64 and $message[$index]  - 128 < 91 )   
    or ( $message[$index]  - 128 >  96 and $message[$index]  - 128 < 123 )
    or ( $message[$index]  - 128 ==  32 )) then $message[$index] - 128
  elif $index == 0 and $message[$index] == $message[-1] then $message[$index] 
  else null 
  end;

def main:
  if length < 1 then  empty
  else rangeArray(length)  
  end

;
main 

#65 238 236 225 46
# cat DATA.lst | jq -r -c -s -f muelasvill.jq
