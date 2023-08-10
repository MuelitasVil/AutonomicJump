 #jq -r -c -s -f melasvill.jq

def rangeArray(Numbers): 

[.[-Numbers[0]:] as $SetOfNumbers 
| [range(1 ; Numbers[1] + 1)] 
| .[] as $element 
| $SetOfNumbers 
| indices($element) | length] | join(" ");


def main:

  if length < 1 then  empty
  else rangeArray([.[0], .[1]])  
  end

;
main 

#cat DATA.lst | jq -r -c -s -f melasvill.jq
#22 23 20 19 28 23 17 17 26 24 27 15 14 16 22 17