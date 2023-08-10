import 'dart:io';
import 'dart:math';


String TrueMaximum(int cantOfdigits, int base, int n_digit) {
  String baseS = "";
  String max = "";

  if (base > 10) {
    baseS = DigitstoHexadecimal(base);
  } else {
    baseS = (base - 1).toString();
  }

  int half = (cantOfdigits ~/ 2).round();
  if (cantOfdigits % 2 == 0) {
    max = baseS * half + "0" * half;
  } else {
    max = baseS * half + "0" + "0" * half;
  }

  return max;
}

String TrueMinimum(int cantOfdigits, int base, int n_digit) {
  String baseS = "";
  String max = "";

  if (base > 10) {
    baseS = DigitstoHexadecimal(base);
  } else {
    baseS = (base - 1).toString();
  }

  int half = (cantOfdigits ~/ 2).round();
  if (cantOfdigits % 2 == 0) {
    max = "0" * half + baseS * half;
  } else {
    max = "0" * (half) + "0" + baseS * half;
  }

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
  int summation =
      HexadecimaltoDigits(NumberBase[n_digit - 1]) * pow(base, n_digit - 1).round();

  if (n_digit == cantOfdigits) {
    return summation;
  }

  summation =
      summation + BasetoDecimal(NumberBase, base, cantOfdigits, n_digit + 1);

  return summation;
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
  sum = sum + HexadecimaltoDigits(num[min]);
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

String LuckyTicket(int NumsOfRanges, int N_number) {
  String LuckyTickes = "";
  int NumberOfLuckyTicket = 1;

  if (N_number < NumsOfRanges) {
    List<String> Information = stdin.readLineSync().toString().split(" ");

    int digits = int.parse(Information[0]);
    int base = int.parse(Information[1]);
    if (digits > 1) {
      String TrueMax = TrueMaximum(digits, base, 1);
      String TrueMin = TrueMinimum(digits, base, 1);

      List<String> numberRevers1 = TrueMax.split("").reversed.toList();
      List<String> numberRevers2 = TrueMin.split("").reversed.toList();

      int truemax = BasetoDecimal(numberRevers1, base, digits, 1);
      int truemin = BasetoDecimal(numberRevers2, base, digits, 1);
      int generateRange = truemax - truemin;

      int cont = 2;
      if (generateRange > 1000000000) {
        int cantOfRanges = generateRange ~/ 1000000000;
        if (cantOfRanges != 0) {
          cantOfRanges++;
        }
        List<bool> Numbers = List.generate(
            1000000000,
            (index) => verifyLuckyTicket(
                fillNumber(DecimaltoBase(index + truemin, base), digits)));
        List<int> Ranges = List.generate(cantOfRanges, (index) => index + 1);
        List<int> EliminarIndices = [];

        int newNumber;
        int index = 0;
        bool band = true;

        Ranges.forEach((Iteracion) {
          Numbers.forEach((element) {
            if (element) {
              cont++;
            }
          });

          if (band) {
            index = 0;
            Numbers.takeWhile((element) => band).forEach((element) {
              newNumber = (index + truemin) * (1000000000 * Iteracion);
              if (newNumber <= truemax) {
                Numbers[index] = verifyLuckyTicket(
                    fillNumber(DecimaltoBase(index + truemin, base), digits));
              } else {
                EliminarIndices.add(newNumber);
              }
              index++;
            });
          }

          EliminarIndices.forEach((element) {
            band = false;
            Numbers.remove(element);
          });
        });
      } else {
        List<int> Numbers =
            List.generate(generateRange, (index) => index + truemin);

        List<String> NumbersToBase = Numbers.map(
                (element) => fillNumber(DecimaltoBase(element, base), digits))
            .toList();

        NumbersToBase.forEach((element) {
          if (verifyLuckyTicket(element)) {
            cont++;
          }
        });
      }
    }else{
      NumberOfLuckyTicket = base;
    }

    LuckyTickes =
        NumberOfLuckyTicket.toString() + " " + LuckyTicket(NumsOfRanges, N_number + 1);
  }

  return LuckyTickes;
}

void main() {
  int NumsOfRanges = int.parse(stdin.readLineSync().toString());
  print(LuckyTicket(NumsOfRanges, 0).trim());
}
