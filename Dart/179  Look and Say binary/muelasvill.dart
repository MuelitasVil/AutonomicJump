// dart compile kernel muelasvill.dart

import 'dart:io';

int TravelString(int Start, String element, String BinaryString) {
  if (Start < BinaryString.length && element == BinaryString[Start]) {
    Start++;
    Start = TravelString(Start, element, BinaryString);
  }

  return Start;
}

List<String> SplitBinaryElements(
    String BinaryString, List<String> ListOfbits, String element, int index) {
  String GroupOfbits = "";
  int MaxIndex;
  if (index < BinaryString.length) {
    MaxIndex = TravelString(index, element, BinaryString);
    GroupOfbits = BinaryString.substring(index, MaxIndex);
    index = MaxIndex;

    if (GroupOfbits.startsWith("1")) {
      element = "0";
    } else {
      element = "1";
    }

    ListOfbits.add(GroupOfbits);
    ListOfbits = 
      SplitBinaryElements(BinaryString, ListOfbits, element, index);
  }

  return ListOfbits;
}

String DecimaltoBinary(int num) {
  String digit = "";
  int mod;
  if (num > 0) {
    mod = num % 2;
    num = num ~/ 2;

    digit = DecimaltoBinary(num) + mod.toString();
  }

  return digit;
}

String LookandSaybinary(String bits) {
  int length = bits.length;
  return DecimaltoBinary(length);
}

int GenerateSequence(String BinaryString) {
  int cont = 0;

  if (BinaryString != "10") {
    cont = 1;
    List<String> ListOfbits = [];
    ListOfbits = SplitBinaryElements(BinaryString, ListOfbits, "1", 0);
    ListOfbits = 
      ListOfbits.map((elemet) => LookandSaybinary(elemet)).toList();
    BinaryString = ListOfbits.join("");
    cont = cont + GenerateSequence(BinaryString);
  }

  return cont;
}

int TravelSGroupsOfChildren(
    int Start, String BinaryString, int cont, int group) {
  if (Start < BinaryString.length &&
      (cont < group || BinaryString[Start] != "1")) {
    if (BinaryString[Start] == "1") {
      cont++;
    }

    Start++;
    Start = TravelSGroupsOfChildren(Start, BinaryString, cont, group);
  }

  return Start;
}

List<String> SplitGroupsOfChildren(
    String BinaryString, List<String> ListOfChildren, int index, int group) {
  String GroupOfbits = "";
  int MaxIndex;
  int cont = 0;
  if (index < BinaryString.length) {
    MaxIndex = TravelSGroupsOfChildren(index, BinaryString, cont, group);
    GroupOfbits = BinaryString.substring(index, MaxIndex);
    index = MaxIndex;

    ListOfChildren.add(GroupOfbits);
    ListOfChildren =
        SplitGroupsOfChildren(BinaryString, ListOfChildren, index, group);
  }

  return ListOfChildren;
}

void main() {
  String BinaryString = stdin.readLineSync().toString();
  int steps = GenerateSequence(BinaryString);
  List<String> ListOfChildren = [];
  ListOfChildren = SplitGroupsOfChildren(BinaryString, ListOfChildren, 0, 1);
  BigInt CantOfParets = BigInt.from(2).pow(ListOfChildren.length - 1);
  print("$steps $CantOfParets");
}

// cat DATA.lst | dart run muelasvill.dart
// 16 2361183241434822606848
