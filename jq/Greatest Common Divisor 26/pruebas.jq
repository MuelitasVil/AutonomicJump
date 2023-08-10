#jq -R -r -c -s -f muelasvill.jq
      
def getGCD(number1;number2):
  [number1,number2,0]
  | until
  (
    .[0] == .[1]; 
    [
      .[0] as $number1
      | .[1] as $number2
      | if $number1 < $number2 then
       $number2 - $number1 
      else 
       $number2
      end,
   
      .[0] as $number1
      | .[1] as $number2
      | if $number2 < $number1 then
       $number1 - $number2 
      else 
       $number1
      end,
      
      .[2] + 1
    ]
  )
  |.[0]
;

def DivideNums:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $element 
  | $element[0] | tonumber as $number1
  | $element[1] | tonumber as $number2
  | getGCD($number1;$number2) as $gcd 
  | (($number1 * $number2) / $gcd) as $lcm
  | ["(",($gcd | tostring)," ",($lcm | tostring),") "]
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

# cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
# (1 35084) (7 8456) (1 5536) (1 5502) (8 80) (24 18240) (56 91448) (1 2328)
# (840 60480) (58 133110) (1 61012) (13 12740) (2 10504) (375 5625)
# (480 12480) (1 4689591) (2 622) (2 2) (3 20925) (83 440481)
