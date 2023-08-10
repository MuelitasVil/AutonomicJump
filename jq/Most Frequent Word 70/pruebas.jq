
def getnumbers(A;C;M;X0;N):
  A as $A
  | C as $C
  | M as $M
  | X0 as $X0
  | N as $N
  | [0, [$X0]]
  |until(
    .[0] >= $N; 
    [
    .[0] + 1,

    .[1] as $ArayX
    | $ArayX + [
    (($A * $ArayX[-1]) + $C) % $M
    ]
    ])
  |.[1]
;

def getX0(A;C;M;X0;N):
  A as $A
  | C as $C
  | M as $M
  | X0 as $X0
  | N as $N
  | [0, $X0]
  |until(
    .[0] >= $N; 
    [
    .[0] + 1,

    .[1] as $X
    | (($A * $X) + $C) % $M
    ])
  |.[1]
;

def GetNs(lengthOfWords):
  [
  [ 
  lengthOfWords
  | .[] | tonumber
  ] as $nums 
  | ($nums | length) as $size
  | [range(0;$size)]
  | .[] as $index
  | $nums[0:$index + 1]
  | add
  ]
;

def lengthOfWords:
  [
  [range(15000)]
  | .[]
  | 6
  ]
;

def EditDictionary(dict;data):
    dict as $dict
    | data as $data
    | $dict
    | setpath([$data]; $dict[$data] + 1)
;

def GenerateDictionary(arrayWords):
  {

  } as $dict
  | arrayWords as $arrayWords
  | ($arrayWords | length) as $size
  | [0, $dict, "", 0]
  | until
  (   .[0] as $index
      | .[1] as $dict
      | $index >= $size; 
    
      [
        (.[0] + 1)
        , 
        .[0] as $index
        | .[1] as $newdict
        | ($arrayWords[$index] | add) as $data
        | EditDictionary($newdict;$data)
        ,
        .[0] as $index
        | .[1] as $newdict
        | .[2] as $string
        | .[3] as $val
        | ($arrayWords[$index] | add) as $data
        | if $newdict[$data] > $val then
          $arrayWords[$index]
          else 
          $string
          end
          , 
          .[0] as $index
        | .[1] as $newdict
        | .[2] as $string
        | .[3] as $val
        | ($arrayWords[$index] | add) as $data
        | if $newdict[$data] > $val then
          $newdict[$data]
          else 
          $val
          end
      ]
  )
  | [.[0], .[1], .[2], .[3]] as $information
  | $information
;

def DivideNums: 
  [ . as $info
  | ("bcdfghjklmnprstvwxz" | split("")) as $consonant
  | ("aeiou" | split("")) as $vowels
  | [
  ($info | tonumber) as $x0
  | lengthOfWords as $lengthOfWords
  | 445 as $A
  | 700001 as $C
  | 2097152 as $M  
  | ([0] + (GetNs($lengthOfWords))) as $Ns
  | $Ns[-1] as $maxN
  | ($Ns | length) as $size
  | getnumbers($A;$C;$M;$x0;$maxN)[1:] as $numbersGenerate
  | $numbersGenerate
  | [range($size - 1)]
  | .[] as $Range
  | [[range($Ns[$Range];$Ns[$Range+1])]
  | .[] as $index
  | $numbersGenerate[$index]]
  ]
  | .[] as $numbersOfWord
  | [($numbersOfWord | length) as $size
  | [range($size)]
  | .[] as $index
  | if $index % 2 == 0 then
    $consonant[($numbersOfWord[$index] % 19)]
    else 
    $vowels[($numbersOfWord[$index] % 5)]
    end
    ]] as $GenerateWords 
    | GenerateDictionary($GenerateWords) as $dict
    | $dict

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