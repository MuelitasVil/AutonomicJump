import 'dart:io';
void main() {

  List<String> Account =  stdin.readLineSync().toString().split(" ");
  List<double> NumsAccount = Account.map((value) => double.parse(value)).toList();

}