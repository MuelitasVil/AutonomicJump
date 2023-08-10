// dart compile kernel mmartinezve.dart

import 'dart:io';

String SumOfDigits(List<int> num, int indice) {
  int? Sumatoria = num[0] * indice;

  num.removeAt(0);

  if (!num.isEmpty) {
    Sumatoria = Sumatoria + int.parse(SumOfDigits(num, indice + 1));
  }

  return Sumatoria.toString();
}

String WalkNumbers(List<String> lista) {
  String answer = "";

  if (!lista.isEmpty) {
    List<int> Numbers =
        lista[0].split("").map((num) => int.parse(num)).toList();
    lista.removeAt(0);
    answer = SumOfDigits(Numbers, 1);
    answer = answer + " " + WalkNumbers(lista);
  }

  return answer;
}

void main() {
  stdin.readLineSync().toString();
  List<String> numbers = stdin.readLineSync().toString().trim().split(" ");
  print(WalkNumbers(numbers).trim());
}

// cat DATA.lst | dart run muelasvill.dart
// 9 9 49 152 184 309 0 249 7 0 19 55 145 11 67 22 154 2 92 13 63 32 170 218 229 17 16 2 74 135 186 11 55 6 140 10 34 2
