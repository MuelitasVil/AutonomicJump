

# Funciona :

#def rangeArray(Numbers): 
#.[-Numbers:] as $SetOfNumbers 
#| [range(0 ; (Numbers-1) + 1)]
#| .[] ;

#def main:
#  if length < 1 then  empty
#  else rangeArray(length)  
#end

#;
#main 
#*/

# No funciona : 

def rangeArray(Numbers): 
.[-Numbers:] as $SetOfNumbers 
| [range(0 ; (Numbers-1) + 1)]
| .[] ;

def main:
  if length < 1 then  empty
  else rangeArray(length)  
  end

;
main 