 #jq -r -c -s -f melasvill.jq

def ModularInverse(numAndMod): 
  numAndMod[0] as $g0
  | numAndMod[1] as $g1
  | 1 as $u0
  | 0 as $u1
  | 0 as $v0
  | 1 as $v1
  | 1 as $i
  | [$g0, $g1, $u0, $u1, $v0, $v1, $i]
  | until
  (
    .[1] == 0;
    [
    #g-1 0
    .[1],
    #g 1
    .[0] as $g_1
    | .[1] as $g
    | $g_1 - ((($g_1 / $g) | floor) * $g),       
    #u - 1 2
    .[3],
    #u 3 
    .[0] as $g_1
    | .[1] as $g
    | .[2] as $u_1
    | .[3] as $u
    | $u_1 - ((($g_1 / $g) | floor) * $u),     
    #v - 1
    .[5], 
    #v1
    .[0] as $g_1
    | .[1] as $g
    | .[4] as $v_1
    | .[5] as $v
    | $v_1 - ((($g_1 / $g) | floor) * $v),
     #i  
    .[6] + 1
   ]
  ) 
  | .[4] as $v_1
  | if ($v_1 < 0) then 
    $v_1 + $g0
    else 
    $v_1
    end
;

def main:

  if length < 1 then  empty
  else ModularInverse([275,9])
  end 

;
main 

#cat DATA.lst | jq -r -c -s -f muelasvill.jq
#22 23 20 19 28 23 17 17 26 24 27 15 14 16 22 17