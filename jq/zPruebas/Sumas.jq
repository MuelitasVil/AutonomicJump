# jq -n -f juan9572.jq

def operateNumbers(index):
  {"var": [.[] | . * 6 + 1 | floor]}
  .var[-index:]
;



def main:
  if length < 1 then empty
  else operateNumbers(.[0]) | join(" ")
  end
;


main

# cat DATA.lst | jq -r -c -s -f juan9572.jq
# 4 3 1 1 3 5 1 5 4 3 1 6 1 4 5 6 6 6 5 1 5 3 3 5 6 1 4 5 4 2
