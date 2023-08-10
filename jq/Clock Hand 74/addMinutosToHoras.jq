#jq -R -r -c -s -f muelasvill.jq
# Este comando hace que se lea todo lo que esta dentro del archivo como uns string


def getPoints(degrees):
  degrees[0] as $degreesHours
  | degrees[1] as $degreesMinutes
  | ($degreesHours * (3.14159265359/180)) * 6;

def isFloat(number): #Verifico si un numero es float si tiene un .
  number 
  | tostring
  | if ( . | contains("."))
  then true 
  else false 
  end
  ;

def GetHours(Information): #Divido el estring en un arreglo donde agarro lo que me interesa
  . 
  | split("\n")
  | .[1]
  | split(" ")
  ;

def arrayOfHours(hours): #Transformo la informacion de string a ints
  hours
  | (.[] | split(":")) as $element
  | [($element[0] | tonumber),($element[1] | tonumber)] as $hourArray
  | if ($hourArray[0]) <= 12 
    then [$hourArray[0] + ($hourArray[1] / 60), $hourArray[1]] 
    else [($hourArray[0] - 12 ) + ($hourArray[1] / 60), $hourArray[1]]
    end ; 

def HoursToDegrees(hours):
  { 
    "3" : 360,  "2" : 30, "1" : 60, "12" : 90,
    "11" : 120, "10" : 150, "9" : 180, "8" : 210,
    "7" : 240,  "6" : 270, "5" : 300, "4" : 330
  } as $DictionaryHours
  | 
  {
  "59" : 96  , "58" : 102 , "57" : 108 , "56" : 114 ,
  "55" : 120 , "54" : 126 , "53" : 132 , "52" : 138 ,
  "51" : 144 , "50" : 150 , "49" : 156 , "48" : 162 ,
  "47" : 168 , "46" : 174 , "45" : 180 , "44" : 186 ,
  "43" : 192 , "42" : 198 , "41" : 204 , "40" : 210 ,
  "39" : 216 , "38" : 222 , "37" : 228 , "36" : 234 ,
  "35" : 240 , "34" : 246 , "33" : 252 , "32" : 258 ,
  "31" : 264 , "30" : 270 , "29" : 276 , "28" : 282 ,
  "27" : 288 , "26" : 294 , "25" : 300 , "24" : 306 ,
  "23" : 312 , "22" : 318 , "21" : 324 , "20" : 330 ,
  "19" : 336 , "18" : 342 , "17" : 348 , "16" : 354 ,
  "15" : 360 , "0" : 90 , "1" : 84 , "2" : 78 ,
  "3" : 72 , "4" : 66 , "5" : 60 , "6" : 54 ,
  "7" : 48 , "8" : 42 , "9" : 36 , "10" : 30 ,
  "11" : 24 , "12" : 18 , "13" : 12 , "14" : 6 ,
  "15" : 0 ,
  } as $Dictionaryminutes
  | . as $Information 
  | .[] as $HourAndMinute
  | if isFloat($HourAndMinute[0]) then 
    
    ($HourAndMinute[0] | tostring | split(".")) as $FloatHour 
    | ((((($DictionaryHours[$FloatHour[0]]  
    -  (30 * ("0." + $FloatHour[1] | tonumber)))
    * (3.14159265359 / 180)) | cos) * 6) + 10)  as $xHours
    
    | ((((($DictionaryHours[$FloatHour[0]]
    -  (30 * ("0." +$FloatHour[1] | tonumber)))
    * (3.14159265359 / 180)) | sin) * 6) + 10)  as $yHours
    
    | ((((($Dictionaryminutes[($HourAndMinute[1] | tostring)]
     * (3.14159265359 / 180))) | cos) * 9) + 10) as $xMinutes 
    
    | ((((($Dictionaryminutes[$HourAndMinute[1] | tostring])
    * (3.14159265359 / 180)) | sin) * 9) + 10)  as $yMinutes 
    
    | [($xHours | tostring), " ",($yHours | tostring)," ",
    ($xMinutes | tostring)," ",($yMinutes | tostring), " " ] | add
    
    else 

    ((((($DictionaryHours[$HourAndMinute[0] | tostring])
    * (3.14159265359 / 180)) | cos) * 6) + 10)  as $xHours
    
    | (((((($DictionaryHours[$HourAndMinute[0] | tostring]))
    * (3.14159265359 / 180)) | sin) * 6) + 10)  as $yHours
    
    | ((((($Dictionaryminutes[($HourAndMinute[1] | tostring)] 
    * (3.14159265359 / 180))) | cos) * 9) + 10) as $xMinutes 
    
    | ((((($Dictionaryminutes[$HourAndMinute[1] | tostring])
    * (3.14159265359 / 180)) | sin) * 9) + 10)  as $yMinutes 
    
    | [($xHours | tostring), " ",($yHours | tostring)," ",
    ($xMinutes | tostring)," ",($yMinutes | tostring)," " ] | add
    
    end ;

def Solution:
  [[GetHours(.) as $hours
  | arrayOfHours($hours)] 
    | . as $informationHours 
    | HoursToDegrees(.)] | add
 ;

def main:
  if length < 1 then  empty
  else Solution
  end
;

main 

#cat DATA.lst | jq -R -r -c -s -f muelasvill.jq
#8.396569743529756 15.781782719251543 10.940756169411715 1.0493029416858377
#13.441458618107996 5.085087734267254 2.2057713659392766 14.499999999998657
#8.096172061568737 15.689941931236959 16.02217545723212 3.3116965707056103 
#14.20545558580065 5.720497305076429 9.05924383059383 1.049302941685255 
#5.8320497772471365 5.683961197967012 11.87120521736268 1.1966715933963545
#9.581461157534603 15.9853843015589 3.311696570702498 16.022175457228663
#5.370252499673063 13.816469321665835 18.221909118784822 6.3393702123209685
#5.869872545836809 14.352246226073092 7.21884705062795 1.4404913533428125
