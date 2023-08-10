//valac ludsrill.gs

[indent=2]

init
  variable:string = "asd";
  var variable2 = va


def Round(data:var)
  var opertation = stdin.read_line().split(" ");
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
  print "%f", differenceOfquotient; 

  if differenceOfquotient < 0 
    differenceOfquotient = differenceOfquotient * -1;
    negative = true;

  if differenceOfquotient >= 0.5 and !negative
    print "%d",  quotientInt+1;
  else if differenceOfquotient >= 0.5 and negative
    print "%d",  quotientInt-1;
  else
    print "%d", quotientInt;


//cat DATA.lst | ./ludsrill
// 29266
