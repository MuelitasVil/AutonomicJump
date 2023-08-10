//valac muelasvill.gs

[indent=2]

init
  CantOfdivisions:int = int.parse(stdin.read_line());
  answer:string = cycle(CantOfdivisions, 0);
  print answer;

def cycle(CantOfdivisions:int, num:int): string
  answer:string = "";
  if num < CantOfdivisions
    answer = Round();
    answer = answer +" "+ cycle(CantOfdivisions, num+1);
  return answer;

def Round(): string
  var opertation = stdin.read_line().split(" ");
  
  answer:string = "";
  
  dividend:string = opertation[0];
  divider:string = opertation[1];
    
  dividendInt:int = int.parse(dividend);
  dividerInt:int = int.parse(divider);

  dividendFloat:float = float.parse(dividend);
  dividerFloat:float = float.parse(divider);

  quotientInt:int = dividendInt / dividerInt;
  quotientFloat:float = dividendFloat / dividerFloat;

  differenceOfquotient:float = quotientFloat - quotientInt;
  negative:bool = false;

  if differenceOfquotient < 0 
    differenceOfquotient = differenceOfquotient * -1;
    negative = true;

  if differenceOfquotient >= 0.5 and !negative
    answer = (quotientInt+1).to_string();
  else if differenceOfquotient >= 0.5 and negative
    answer = (quotientInt-1).to_string();
  else
    answer = (quotientInt).to_string();

  return answer

//cat DATA.lst | ./muelasvill
//-1 0 9 26 3083 138640 11 4106 8 123273 -3 20 3 3164 1 12 -3 154375
//7621 6855 28199 -6 0 13 14 8
