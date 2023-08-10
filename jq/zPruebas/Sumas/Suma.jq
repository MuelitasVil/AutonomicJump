#jq -n -f juan9572.jq

def sumValues(array):
  .[-array:] | add
;

def main:
  if length < 1 then empty
  else sumValues(.[0])
  end
;

main

# cat DATA.lst | jq -s -f Suma.jq
# 19985
