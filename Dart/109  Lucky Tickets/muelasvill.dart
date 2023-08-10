// dart compile kernel muelasvill.dart

import 'dart:io';
import 'dart:math';

String Maximum(int cantOfdigits, int base, int n_digit) {
  String baseS = "";
  String max = "";

  if (base > 10) {
    baseS = DigitstoHexadecimal(base - 1);
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

String FillNumber(String number,int cantOfdigits) {
  if (number.length < cantOfdigits ~/ 2) {
    number = ("0" * (cantOfdigits ~/ 2 - number.length)) + number;
  }

  return number;
}

int SumDigits(String number, int cantOfdigits, int index) {
  int sum = 0;

  if (index < cantOfdigits ~/ 2) {
    sum = HexadecimaltoDigits(number[index]);
    sum = sum + SumDigits(number, cantOfdigits, index + 1);
  }

  return sum;
}

int CounterSum(List<int> SumsOfNumbers, int value, bool even, int base) {
  List<int> CopyOfSumsOfNumbers = List.from(SumsOfNumbers);
  CopyOfSumsOfNumbers.removeWhere((element) => element != value);

  if (!even) {
    return (CopyOfSumsOfNumbers.length * CopyOfSumsOfNumbers.length) * base;
  }

  return (CopyOfSumsOfNumbers.length * CopyOfSumsOfNumbers.length);
}

List<int> ListCounterSum(List<int> CountOfSums, List<int> SumsOfNumbers,
    int index, bool even, int base) {
  if (index < CountOfSums.length) {
    CountOfSums[index] = CounterSum(SumsOfNumbers, index, even, base);
    CountOfSums =
        ListCounterSum(CountOfSums, SumsOfNumbers, index + 1, even, base);
  }

  return CountOfSums;
}

int multiplicationRule(int value, int base, bool even) {
  int Answer = 0;

  if (even) {
    Answer = ((value * value) * base);
  } else {
    Answer = ((value * value));
  }

  return Answer;
}

String LuckyTicket(int NumsOfRanges, int N_number) {
  String LuckyTickes = "";

  if (N_number < NumsOfRanges) {
    List<String> Information = stdin.readLineSync().toString().split(" ");
    int CantOfLuckyNumbers = 0;
    bool band = true;
    bool evenDigits = false;
    int digits = int.parse(Information[0]);
    int base = int.parse(Information[1]);

    if (digits != 1) {
      band = false;
      evenDigits = false;

      String limit = Maximum(digits, base, 1);
      List<String> numberRevers = limit.split("").reversed.toList();
      int generateRange = BasetoDecimal(numberRevers, base, digits, 1);
      List<int> Numbers = List.generate(generateRange + 1, (index) => index);

      List<int> SumsOfNumbers = Numbers.map((element) => SumDigits(
              FillNumber(DecimaltoBase(element, base), digits), digits, 0))
          .toList();

      int maxSum = SumsOfNumbers.last;
      List<int> CountOfSums = List.generate(maxSum + 1, (index) => index);

      if (digits % 2 == 0) {
        evenDigits = true;
      }

      CountOfSums =
          ListCounterSum(CountOfSums, SumsOfNumbers, 0, evenDigits, base);

      CantOfLuckyNumbers =
          CountOfSums.reduce((value, element) => value + element);
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
// 103152137 6 137292 6814544 9331 146 1469 11207600921
// 4324576400 1703636 33825
