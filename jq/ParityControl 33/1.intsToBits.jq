 #jq -r -c -s -f melasvill.jq


def rangeArray(CantOfletters): 

[.[-CantOfletters:] as $message 
| [range(0 ; (CantOfletters-1) + 1)]
| .[] as $index
| if $index != 0 and $message[$index] != $message[-1] then  
  [$message[$index],""]|until(.[0] < 1; [(.[0] / 2 | floor), (.[0] % 2 | tostring) + .[1] ])| # Esta linea hace la transformacion 
  .[1] #| split("") | indices("1") | length 
  else $message[$index] 
  end];

def main:
  if length < 1 then  empty
  else rangeArray(length)  
  end

;
main 

#65 238 236 225 46
# cat DATA.lst | jq -r -c -s -f muelasvill.jq
