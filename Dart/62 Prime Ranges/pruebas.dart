// dart compile kernel muelasvill.dart

import 'dart:io';
import 'dart:math';

bool PrimeNumber2(int verifynumber, int NumSqr, int num) {
  bool primo = false;

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
    primo = PrimeNumber2(verifynumber, NumSqr, num + 2);
  } else {
    return true;
  }

  return primo;
}

bool PrimeNumber(int number) {
  int Origintam;
  int NumSqr = sqrt(number).round();

  if (number == 2 || number == 3 || number == 5) {
    return false;
  }

  List<int> listaNums = List.generate(NumSqr, (index) => index + 2);
  //print(listaNums);
  Origintam = listaNums.length;
  listaNums.removeWhere((element) => number % element == 0);
  //print(listaNums);

  if (listaNums.length != Origintam) {
    return false;
  }

  return true;
}

void RangeOfPrimes(int min, int max) {
  List<int> listaNums = List.generate(max - (min - 1), (index) => max - index);
  print(listaNums);
}

void main() {
  //int NumsOfAccount = int.parse(stdin.readLineSync().toString());
  //int NumSqr = sqrt(NumsOfAccount).round();
  //print(NumSqr);
  //print(sqrt(NumsOfAccount));

  //List<int> listaNums = List.generate(NumSqr-1, (index) => index + 2);
  //listaNums.removeWhere((element) => NumsOfAccount % element == 0);
  //print(listaNums);

  //List<int> listaNums2 = List.generate(10 - 4, (index) => 10 - index);
  //print(listaNums2);

  //print(i);

  for (int i = 0; i < 100; i++) {
    if (!(PrimeNumber2(i, sqrt(i).round(), 3))) {
      print(i);
    }
  }

  RangeOfPrimes(1, 10);
}

// cat DATA.lst | dart run muelasvill.dart
// 152 137 34 137 324 102 92 59 10 92 23 39 20 273 273 31 5
