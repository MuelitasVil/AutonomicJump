import 'dart:io';
import 'dart:math';

String Maximum(int cantOfdigits, int base, int n_digit) {
  String baseS = "";
  String max = "";

  if (base > 10) {
    baseS = DigitstoHexadecimal(base-1);
  } else {
    baseS = (base - 1).toString();
  }

  int half = (cantOfdigits ~/ 2).round();
  max = baseS * half;

  return max;
}

String DigitstoHexadecimal(int num) {
  String char = "";

  switch (num) {
    case 0:
      {
        char = "0";
      }
      break;
    case 1:
      {
        char = "1";
      }
      break;
    case 2:
      {
        char = "2";
      }
      break;
    case 3:
      {
        char = "3";
      }
      break;
    case 4:
      {
        char = "4";
      }
      break;
    case 5:
      {
        char = "5";
      }
      break;
    case 6:
      {
        char = "6";
      }
      break;
    case 7:
      {
        char = "7";
      }
      break;
    case 8:
      {
        char = "8";
      }
      break;
    case 9:
      {
        char = "9";
      }
      break;
    case 10:
      {
        char = "A";
      }
      break;
    case 11:
      {
        char = "B";
      }
      break;
    case 12:
      {
        char = "C";
      }
      break;
    case 13:
      {
        char = "D";
      }
      break;
    case 14:
      {
        char = "E";
      }
      break;
    case 15:
      {
        char = "F";
      }
      break;
    default:
      {
        print("DH : This don't happend");
      }
      break;
  }

  return char;
}

int HexadecimaltoDigits(String num) {
  int value = 0;

  switch (num) {
    case "0":
      {
        value = 0;
      }
      break;
    case "1":
      {
        value = 1;
      }
      break;
    case "2":
      {
        value = 2;
      }
      break;
    case "3":
      {
        value = 3;
      }
      break;
    case "4":
      {
        value = 4;
      }
      break;
    case "5":
      {
        value = 5;
      }
      break;
    case "6":
      {
        value = 6;
      }
      break;
    case "7":
      {
        value = 7;
      }
      break;
    case "8":
      {
        value = 8;
      }
      break;
    case "9":
      {
        value = 9;
      }
      break;
    case "A":
      {
        value = 10;
      }
      break;
    case "B":
      {
        value = 11;
      }
      break;
    case "C":
      {
        value = 12;
      }
      break;
    case "D":
      {
        value = 13;
      }
      break;
    case "E":
      {
        value = 14;
      }
      break;
    case "F":
      {
        value = 15;
      }
      break;
    default:
      {
        print("HD : This don't happend");
      }
      break;
  }

  return value;
}

String DecimaltoBase(int num, int base) {
  String digit = "";
  int mod;
  if (num > 0) {
    mod = num % base;
    num = num ~/ base;
  
    digit = DecimaltoBase(num, base) + DigitstoHexadecimal(mod);
  }

  return digit;
}

int BasetoDecimal(
    List<String> NumberBase, int base, int cantOfdigits, int n_digit) {
  int summation = HexadecimaltoDigits(NumberBase[n_digit - 1]) *
      pow(base, n_digit - 1).round();

  if (n_digit == cantOfdigits ~/ 2) {
    return summation;
  }

  summation =
      summation + BasetoDecimal(NumberBase, base, cantOfdigits, n_digit + 1);

  return summation;
}

int SumDigits(String number, int cantOfdigits) {
  if (number.length < cantOfdigits ~/ 2) {
    number = ("0" * (cantOfdigits ~/ 2 - number.length)) + number;
  }

  print(number);
  int sum = 0;
  number.split("").forEach((element) {
    sum = sum + HexadecimaltoDigits(element);
  });

  return sum;
}

int GetNum(Map<String, int> Cities, String element) {
  int num = Cities.update(element, (value) => value);
  return num;
}

Map<int, int> generateCounterSet(List<int> SumsOfNumbers) {
  Map<int, int> CountOfSums = {};
  SumsOfNumbers.forEach((element) {
    if (!CountOfSums.containsKey(element)) {
      CountOfSums[element] = 1;
    } else {
      //print("Editar");
      CountOfSums.update(element, (value) => value = value + 1);
    }
  });
  return CountOfSums;
}

void main() {
  // Idea actual
  //Para solucionar el ejercicio vamos a aprovecharnos de las posibles permutaciones con elemntos iguales
  //Ejemplo :
  // Para 4 digitos y base dos tenemos
  // Suma 1 = 01 10 -> Teniendo en cuenta la ley de la multiplicacion tenemos 2 x 2
  //
  //01 01
  //01 10
  //10 01
  //10 10
  //
  //Final mente obtenemos las posibles combinaciones que den 1
  //
  // Suma 2 = 11
  List<String> Information = stdin.readLineSync().toString().split(" ");
  int CantOfLuckyNumbers = 0;
  bool band = true;
  int digits = int.parse(Information[0]);
  int base = int.parse(Information[1]);
  
  if(digits != 1){
  
  band = false;
  String limit = Maximum(digits, base, 1);

  print("Numero de digitos : $digits");
  print("Base de los digitos : $base");
  print("La mitad maxima es : $limit");

  List<String> numberRevers = limit.split("").reversed.toList();
  int generateRange = BasetoDecimal(numberRevers, base, digits, 1);
  List<int> Numbers = List.generate(generateRange+1, (index) => index);
  print(Numbers);
  
  List<int> SumsOfNumbers =
      Numbers.map((element) => SumDigits(DecimaltoBase(element, base), digits))
          .toList();
  //print(SumsOfNumbers);
  
  Map<int, int> CountOfSums = generateCounterSet(SumsOfNumbers);
  
  CountOfSums.forEach((key, value) { 
    //print("$key : $value");
    if(digits % 2 != 0){
    CantOfLuckyNumbers = CantOfLuckyNumbers + value*(base * value);
    } else {
    CantOfLuckyNumbers = CantOfLuckyNumbers + ((value * value));
    }
    
    
  });
  
  }
  if(band){
    CantOfLuckyNumbers = base;
  }
  print(CantOfLuckyNumbers);


  

  //print("Numero  maximo  : $max");
  //print("Numero  vermax  : $truemax");
  //print("Numero  vermin  : $truemin");
  //print("Recorrer        : ${truemax - truemin}");
  //print(Numbers);
  //print("Ejemplo octal to decimal");
  //print(DecimaltoBase(179, 8));

  //print(NumbersToBase);

  //print(verifyLuckyTicket("0111"));

  // Revisasr si multiplicacion sirve
  //print("asd" * 3);

  //15
  
  //5 15 Mal
  // Se espera 33825
  // Salida (Multiplicando por 2 si es impar ) 5090
  // Salida sin multiplcar nada 2545
  
  // 1 12 Da bien
  // Se espera 12

  //13 6 Mal
  // Se espera 869042856
  // Salida (Multiplicando por 2 si es impar ) 289680952
  // Salida sin multiplcar nada 144840476

  //13 6
  // Se espera 869042856
  // Salida (Multiplicando por 2 si es impar ) 289680952
  // Salida sin multiplcar nada 144840476

  //11 14
  // Se espera 124800339496
  // Salida (Multiplicando por 2 si es impar ) 20513837718
  // Salida sin multiplcar nada 144840476
  
  //11 8
  // Se espera 465593664
  // Salida (Multiplicando por 2 si es impar ) 116398416 
  // Salida sin multiplcar nada 144840476

  //23 3
  //Se espera 9723406581
  //Salida 6482271054

  //1 8
  // Se espera 8
  // Sale 8
  //7 13
  // Numero 10084583
  //16 6 Explota
  // Numero 2821109907455
  //7 11
  // Numero 162393
  //3 7
  // Numero 342
  //20 3
  // Numero
}
