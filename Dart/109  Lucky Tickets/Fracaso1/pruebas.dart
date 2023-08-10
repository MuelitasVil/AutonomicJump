import 'dart:io';
import 'dart:math';

String Maximum(int cantOfdigits, int base, int n_digit) {
  String max = (base - 1).toString();
  if (n_digit == cantOfdigits) {
    return max;
  }
  max = max + Maximum(cantOfdigits, base, n_digit + 1);
  return max;
}

int BasetoDecimal(
    List<String> NumberBase, int base, int cantOfdigits, int n_digit) {
  int summation =
      int.parse(NumberBase[n_digit - 1]) * pow(base, n_digit - 1).round();
  if (n_digit == cantOfdigits) {
    return summation;
  }

  summation =
      summation + BasetoDecimal(NumberBase, base, cantOfdigits, n_digit + 1);

  return summation;
}

String DigitstoHexadecimal(int num) {
  String char = "";
  
  switch (num) {
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
        char = "f";
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

    if (mod < 10) {
      digit = DecimaltoBase(num, base) + mod.toString();
    } else {
      digit = DecimaltoBase(num, base) + DigitstoHexadecimal(mod);
    }
  }

  return digit;
}

String fillNumber(String number, int cantOfdigits) {
  if (number.length < cantOfdigits) {
    number = ("0" * (cantOfdigits - number.length)) + number;
  }

  return number;
}

int SumDigits(List<String> num, int min, int max) {
  int sum = 0;
  num.takeWhile((value) => min < max).forEach((element) {
    if (int.parse(num[min]) >= 10) {
      sum = sum + HexadecimaltoDigits(num[min]);
    } else {
      sum = sum + int.parse(num[min]);
    }

    min++;
  });

  return sum;
}

bool verifyLuckyTicket(String number) {
  int minimumL, maximumL, sumL;
  int minimumR, maximumR, sumR;
  bool LuckyTicket = false;
  List<String> digits = number.split("");
  int tam = digits.length;

  if (tam % 2 == 0) {
    minimumL = 0;
    maximumL = tam ~/ 2;

    minimumR = tam ~/ 2;
    maximumR = tam;
  } else {
    minimumL = 0;
    maximumL = tam ~/ 2;

    minimumR = (tam ~/ 2) + 1;
    maximumR = tam;
  }

  sumL = SumDigits(number.split(""), minimumL, maximumL);
  sumR = SumDigits(number.split(""), minimumR, maximumR);

  if (sumL == sumR) {
    LuckyTicket = true;
  }

  return LuckyTicket;
}

void main() {

  List<String> Information = stdin.readLineSync().toString().split(" ");

  int digits = int.parse(Information[0]);
  int base = int.parse(Information[1]);
  
  String number = Maximum(digits, base, 1);
  print(number);

  List<String> numberRevers = number.split("").reversed.toList();
  print(numberRevers);

  int max = BasetoDecimal(numberRevers, base, digits, 1);
  print("Numero  maximo : $max");

  
  List<int> Numbers = List.generate(max+1, (index) => index + 1);
  //print(Numbers);
  //print("Ejemplo octal to decimal");
  //print(DecimaltoBase(179, 8));

  List<String> NumbersToBase =
      Numbers.map((element) => fillNumber(DecimaltoBase(element, base), digits))
          .toList();
  //print(NumbersToBase);

  //print(verifyLuckyTicket("0111"));


  int cont = 0;
  NumbersToBase.forEach((element) {
    if(verifyLuckyTicket(element)){
      cont++;
    }
  });

  print(cont);
  print("Como asi, si llega aca");
  // Revisasr si multiplicacion sirve
  //print("asd" * 3);
  //12 9 Explota
  // Numero 282429536480
  //9 2
  // Numero 511
  //8 3
  // Numero 6560
  //2 8
  // Numero 63
  //4 14
  // Numero 3349
  //8 9
  // Numero 43046720
  //4 12
  // Numero 1885
  //21 5
  // Numero 476837158203124 Explota
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
