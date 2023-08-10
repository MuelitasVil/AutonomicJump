#jq -R -r -c -s -f muelasvill.jq

def EditDictionary(dict;data):
    dict
    | .[data] += 1 
    | .
;

def DivideNums:
  {
    "a" : 2
  } as $dict
  | EditDictionary($dict;"v")

; 

def main:
  if length < 1 then  empty
  else DivideNums
  end
;
main 

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# (-31 952) (63 619) (-51 -681) (87 577) (50 168) (-51 69) (47 -508)
# (-82 -912) (-32 -671) (40 -557) (22 -311) (60 -759) (74 -91) (74 832) 