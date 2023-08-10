def DivideNums:
  [. 
  | split("\n") as $setOfNums
  | $setOfNums[1:-1]
  | .[] 
  | split(" ") as $element 
  | $element[0] | tonumber as $day1
  | $element[1] | tonumber as $hour1 
  | $element[2] | tonumber as $minute1
  | $element[3] | tonumber as $second1
  | $element[4] | tonumber as $day2 
  | $element[5] | tonumber as $hour2
  | $element[6] | tonumber as $minute2
  | $element[7] | tonumber as $second2
  | (($day1 * 86400) + 
    ($hour1 * 3600) + 
    ($minute1 * 60) + 
    $second1) as $TotalSeconds1
  | (($day2 * 86400) + 
    ($hour2 * 3600) + 
    ($minute2 * 60) + 
    $second2) as $TotalSeconds2
  | ($TotalSeconds2 - $TotalSeconds1) as $TimeDifenrence 
  | (($TimeDifenrence  / 86400) | floor) as $Difday
  | ($TimeDifenrence % 86400) as $residue
  | (($residue / 3600) | floor) as $Difhour
  | ($residue % 3600) as $residue
  | (($residue / 60) | floor) as $Difmin
  | ($residue % 60) as $DifSeg
  | ["(",($Difday | tostring)," "
  ,($Difhour|tostring)," "
  ,($Difmin|tostring)
  ," "
  ,($DifSeg|tostring),") "]
  | add]
  | add
;

def main:
  if length < 1 then  empty
  else DivideNums
  end
;

main 

# 29 5 4 15 22 29 3 30 23 26 6 16 26 8 29 5 3 18 5 14 11 15 21 17 25 2 1 23
# 18 28 22 2 14 17 8 6 20 8 21 18 31 12 3 29 19 21 26 5 9 1 25 7 0 29 18