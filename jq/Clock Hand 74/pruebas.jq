#jq -R -r -c -s -f muelassvill.jq
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
  "11" : 24 , "12" : 18 , "13" : 12 , "14" : 6
  } as $Dictionaryminutes
  | . as $Information 
  | .[] as $HourAndMinute
  | if isFloat($HourAndMinute[0]) then 
    
    ($HourAndMinute[0] | tostring | split(".")) as $FloatHour 
    | $FloatHour
    | ((((($DictionaryHours[$FloatHour[0]]
    +  (30 * ("0." +$FloatHour[1] | tonumber)))
    * (3.14159265359 / 180)) | cos) * 6) + 10)  as $xHours
    
    | ((((($DictionaryHours[$FloatHour[0]]
    +  (30 * ("0." +$FloatHour[1] | tonumber)))
    * (3.14159265359 / 180)) | sin) * 6) + 10)  as $yHours
    
    | ((((($Dictionaryminutes[($HourAndMinute[1] | tostring)]
     * (3.14159265359 / 180))) | cos) * 9) + 10) as $xMinutes 
    
    | ((((($Dictionaryminutes[($HourAndMinute[1] | tostring)]
     * (3.14159265359 / 180))) | sin) * 9) + 10) as $xMinutes 
    
    | [($xHours | round(8) | tostring), " ",($yHours| round(8) | tostring)," ",
    ($xMinutes | round(8) | tostring)," ",($yMinutes| round(8) |tostring) ] | add
    
    else 

    ((((($DictionaryHours[$HourAndMinute[0] | tostring])
    * (3.14159265359 / 180)) | cos) * 6) + 10)  as $xHours
    
    | (((((($DictionaryHours[$HourAndMinute[0] | tostring]))
    * (3.14159265359 / 180)) | sin) * 6) + 10)  as $yHours
    
    | ((((($Dictionaryminutes[($HourAndMinute[1] | tostring)]
     * (3.14159265359 / 180))) | cos) * 9) + 10) as $xMinutes 
    
    | ((((($Dictionaryminutes[($HourAndMinute[1] | tostring)]
     * (3.14159265359 / 180))) | sin) * 9) + 10) as $xMinutes 
    
    | [($xHours | round(2) | tostring), " ",($yHours | round(8) | tostring)," ",
    ($xMinutes| round(8)  | tostring)," ",($yMinutes| round(8) |tostring) ] | add
    
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

#cat DATA.lst | jq -R -r -c -s -f muelassvill.jq
#22 23 20 19 28 23 17 17 26 24 27 15 14 16 22 17