// dart compile kernel muelasvill.dart

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
      CountOfSums.update(element, (value) => value = value + 1);
    }
  });
  return CountOfSums;
}

String LuckyTicket(int NumsOfRanges, int N_number) {
  String LuckyTickes = "";

  if (N_number < NumsOfRanges) {
    List<String> Information = stdin.readLineSync().toString().split(" ");
    int CantOfLuckyNumbers = 0;
    bool band = true;
    int digits = int.parse(Information[0]);
    int base = int.parse(Information[1]);

    if (digits != 1) {
      band = false;

      String limit = Maximum(digits, base, 1);
      List<String> numberRevers = limit.split("").reversed.toList();
      int generateRange = BasetoDecimal(numberRevers, base, digits, 1);
      List<int> Numbers = List.generate(generateRange + 1, (index) => index);

      List<int> SumsOfNumbers = Numbers.map(
              (element) => SumDigits(DecimaltoBase(element, base), digits))
          .toList();

      Map<int, int> CountOfSums = generateCounterSet(SumsOfNumbers);

      CountOfSums.forEach((key, value) {
        if (digits % 2 != 0) {
          CantOfLuckyNumbers = CantOfLuckyNumbers + ((value * value) * base);
        } else {
          CantOfLuckyNumbers = CantOfLuckyNumbers + ((value * value));
        }
      });
    }
    if (digits % 2 != 0) {
      CantOfLuckyNumbers = CantOfLuckyNumbers;
    }

    if (band) {
      CantOfLuckyNumbers = base;
    }

    LuckyTickes = CantOfLuckyNumbers.toString() +
        " " +
        LuckyTicket(NumsOfRanges, N_number + 1);
  }

  return LuckyTickes;
}

void main() {
  int NumsOfRanges = int.parse(stdin.readLineSync().toString());
  print(LuckyTicket(NumsOfRanges, 0).trim());
}

// cat DATA.lst | dart run muelasvill.dart
// 9 4816030 35751527189 17232084 221367 8408369643111 3432 10 7 25676
// 465593664 204763
