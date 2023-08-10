// dart compile kernel muelasvill.dart

import 'dart:io';
import 'dart:math';

bool PrimeNumber(int verifynumber, int NumSqr, int num) {
  bool prime = false;

  if (verifynumber == 1 || verifynumber == 0) {
    return true;
  }
  if (verifynumber == 2 || verifynumber == 3 || verifynumber == 5) {
    return false;
  }

  if (verifynumber % 2 == 0) {
    return true;
  }

  if (num > NumSqr && verifynumber % num != 0) {
    return false;
  }

  if (verifynumber % num != 0) {
    prime = PrimeNumber(verifynumber, NumSqr, num + 2);
  } else {
    return true;
  }

  return prime;
}

int RangeOfPrimes(int min, int max) {
  List<int> listaNums = 
  List.generate(max - (min - 1), (index) => max - index);
  listaNums.removeWhere((element) => 
  PrimeNumber(element, sqrt(element).round(), 3));
  return listaNums.length;
}

String PrimesRanges(int NumsOfRanges, int number_range) {
  String CantOfPrimes = "";

  if (number_range < NumsOfRanges) {
    List<String> Range = stdin.readLineSync().toString().split(" ");
    List<int> Rangeint = Range.map((value) => int.parse(value)).toList();
    CantOfPrimes = RangeOfPrimes(Rangeint[0], Rangeint[1]).toString();
    CantOfPrimes =
        CantOfPrimes + " " + PrimesRanges(NumsOfRanges, number_range + 1);
  }

  return CantOfPrimes;
}

void main() {
  int NumsOfRanges = int.parse(stdin.readLineSync().toString());
  print(PrimesRanges(NumsOfRanges, 0).trim());
}

// cat DATA.lst | dart run muelasvill.dart
// 33408 37663 46774 2655 11395 8088 7008 6660 21975 9795 37731 8545 5120 1810
