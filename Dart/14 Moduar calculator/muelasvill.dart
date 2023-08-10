// dart compile kernel mmartinezve.dart

import 'dart:io';

BigInt calculator(BigInt number) {
  List<String> Operation = stdin.readLineSync().toString().split(" ");
  BigInt calculation = number;

  switch (Operation[0]) {
    case "+":
      {
        calculation = number + BigInt.parse(Operation[1]);
      }
      break;

    case "*":
      {
        calculation = number * BigInt.parse(Operation[1]);
      }
      break;

    case "%":
      {
        calculation = number % BigInt.parse(Operation[1]);
      }
      break;
  }

  if (Operation[0] != "%") {
    return calculator(calculation);
  }

  return calculation;
}

void main() {
  BigInt number = BigInt.parse(stdin.readLineSync().toString());
  print(calculator(number));
}

// cat DATA.lst | dart run muelasvill.dart
// 3466
