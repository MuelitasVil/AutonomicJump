def IntegerToBinary(number):
  [number,""]
  |until(
    .[0] <= 0;
    [
    ((.[0] / 2) | floor), 
     
    .[1] + ((.[0] % 2) | tostring)
    ])
  |.[1]
;

def complement2(bits):
  [bits 
  | split("") as $arrayBits
  | ($arrayBits | index("1")) as $firstOne
  | ($arrayBits | length) as $size
  | [range($size)]
  | .[] as $index
  | if $index <= $firstOne then
    $arrayBits[$index]
    else 
      if $arrayBits[$index] == "1" then
        "0"
      else 
        "1"
      end 
    end]   

;

def DivideNums:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $element
  | $element
  | (.[] | tonumber) as $number
  | if $number >= 0 then
    IntegerToBinary($number)
    | split("")
    | indices("1")
    | length as $CantOnes
    | [$CantOnes | tostring, " "]
    | add
    else
    IntegerToBinary(-1 * $number) as $bits
    | complement2($bits) as $Complement2
    | ($Complement2 | length) as $size
    | (($Complement2 | indices("1")) | length) as $CantOnes
    | ($CantOnes + (32 - $size)) as $CantOnes
    | [$CantOnes | tostring, " "]
    | add
    end 
  ]
  | add

;

def main:
  if length < 1 then  empty
  else DivideNums
  end
;

main 

  