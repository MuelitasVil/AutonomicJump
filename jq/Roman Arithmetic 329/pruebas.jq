
def divideOperation(operation):
  operation as $mathOperation 
  | indices(" ") as $Rangeindex
  | $Rangeindex
  | $mathOperation[:$Rangeindex[0]] as $firtNumber
  | $mathOperation[$Rangeindex[0] + 1:$Rangeindex[1]] | add as $operation
  | $mathOperation[$Rangeindex[1] + 1:] as $secondNumber
  | [$firtNumber,$operation,$secondNumber]
;

def isNormalNumber(DictionaryRomanNumerals;num1;num2):
  DictionaryRomanNumerals as $DictionaryRomanNumerals 
  | num1 as $num1 
  | num2 as $num2 
  | if $DictionaryRomanNumerals[$num1 | tostring] 
    >= $DictionaryRomanNumerals[$num2 | tostring] then
    true
    else 
    false
    end 
;   
  
def RomanNumerToDecimal(RomanNumber):
  {
    "I" : 1,
    "V" : 5,
    "X" : 10,
    "L" : 50,
    "C" : 100,
    "D" : 500,
    "M" : 1000
  } as $DictionaryRomanNumerals 
  | $DictionaryRomanNumerals
  | RomanNumber as $RomanNumber
  | ($RomanNumber | length) as $size
  | [0, 0]
  | until
  (
    .[0] >= $size; 
    [
        .[0] as $index
        | .[1] as $sumation
        | $RomanNumber[$index] as $num1
        | $RomanNumber[$index + 1] as $num2 
        | if isNormalNumber($DictionaryRomanNumerals;$num1;$num2) 
          and $index < $size then
            $index + 1
          else 
            $index + 2
        end,

        .[0] as $index
        | .[1] as $sumation
        | $RomanNumber[$index] as $num1
        | $RomanNumber[$index + 1] as $num2 
        | if isNormalNumber($DictionaryRomanNumerals;$num1;$num2)
          and $index < $size then
            $sumation + $DictionaryRomanNumerals[$num1 | tostring]
          else 
            $sumation 
            + ($DictionaryRomanNumerals[$num2 | tostring]
            - $DictionaryRomanNumerals[$num1 | tostring])
        end 

    ]
  )
  |.[1]
;

def getRomanNumeral(total;number):
  total as $total
  | number as $number 
  | (($total / $number) | floor) as $quotient
  | ($total % $number) as $residue
  | {"1000" : 900,
    "500" : 400,
    "100" : 90,
    "50" : 40,
    "10" : 9,
    "5" : 4
    } as $specialCases
  | if $residue >= $specialCases[($number | tostring)] 
    and $residue < $number then
    [$quotient, $specialCases[($number | tostring)]]
    else 
    [$quotient, 0]
    end
;

def getSymbols(cant;romanSymbol;residue):
  romanSymbol as $romanSymbol
  | cant as $cant
  | residue as $residue
  | if $cant != 0 then 
    ($romanSymbol * $cant) + $residue
    else 
    $residue
    end
;
      
def IntegerToRomanNumber(num):
  num as $num
  |  {
    "1" : "I",
    "5" : "V",
    "10" : "X",
    "50" : "L",
    "100" : "C",
    "500" : "D",
    "1000" : "M",
    "900" : "CM",
    "400" : "CL",
    "90" : "XC",
    "40" : "XL",
    "9" : "IX",
    "4" : "IV",
    "0" : ""
  } as $DictionaryRomanNumerals 
  | [1000,500,100,50,10,5,1] as $numbers 
  | [0,$num,""]
  | until
  (
    .[0] > 6; 
    [
      .[0] as $index
      | $index + 1,

      .[0] as $index
      | .[1] as $total
      | $numbers[$index] as $number
      | getRomanNumeral($total;$number) as $info
      | ($total - (($info[0] * $number) + $info[1]))
      ,
      .[0] as $index
      | .[1] as $total
      | .[2] as $romanNumber
      | $numbers[$index] as $number
      | getRomanNumeral($total;$number) as $info
      | getSymbols(
        $info[0];
        $DictionaryRomanNumerals[$number | tostring];
        $DictionaryRomanNumerals[$info[1] | tostring]
        ) as $romanSymbols
      | $romanNumber + $romanSymbols
    ]
  )
  | .[2]

;
def getAnswer(operation;num1;num2):
  operation as $operation
  | num1 as $num1
  | num2 as $num2
  | if $operation == "+" then
    $num1 + $num2
    else 
    $num1 - $num2 
    end 
;  

def DivideNums:
  [
   . 
  | split("\n") as $setOfOperation
  | $setOfOperation[1:-1]
  | .[] 
  | split("") as $mathOperation 
  | divideOperation($mathOperation) as $mathOperation
  | $mathOperation[0] as $firtNumber
  | $mathOperation[1] as $operation
  | $mathOperation[2] as $secondNumber
  | RomanNumerToDecimal($firtNumber) as $num1
  | RomanNumerToDecimal($secondNumber) as $num2
  | getAnswer($operation;$num1;$num2) as $result
  | [IntegerToRomanNumber($result), " "]
  | add
  ] 
  | add
;

def main:
  if length < 1 then  empty
  else DivideNums
  end
;

main 

# MMCCCLIII DCLXIX DCLXXXIV MMCCCLXXI MMCCXLIV MMCCCXXXIII MMMXXVIII MDCXXVI
# MMMCMXXVII MMDCXCV MCMXCIII CCCXCV CMXLII MMMDCCX MMMDCCXCI MDCXXXVII
# MMMCIII MMDCCCXXII MCCCLXI DXLVI MMCCLXXVIII MMDCCIV
