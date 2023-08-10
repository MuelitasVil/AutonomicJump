// dart compile kernel muelasvill.dart

import 'dart:io';

String BitsToHexadecimal(String bits){
  
  if(bits == "0000"){
    return "0";
  }

  if(bits == "0001"){
    return "1";
  }

  if(bits == "0010"){
    return "2";
  }

  if(bits == "0011"){
    return "3";
  }

  if(bits == "0100"){
    return "4";
  }

  if(bits == "0101"){
    return "5";
  }

  if(bits == "0110"){
    return "6";
  }

  if(bits == "0111"){
    return "7";
  }

  if(bits == "1000"){
    return "8";
  }

  if(bits == "1001"){
    return "9";
  }

  if(bits == "1010"){
    return "A";
  }

  if(bits == "1011"){
    return "B";
  }

  if(bits == "1100"){
    return "C";
  }

  if(bits == "1101"){
    return "D";
  }

    if(bits == "1110"){
    return "D";
  }

  if(bits == "1111"){
    return "F";
  }

  return "";

}

String TextToBits(Map<String, String> encode, String text) {
  return encode[text].toString();
}

String FillOutString(String text){

  print(text.length);
  if(text.length != 4){

    text = FillOutString(text + "0");

  }

  return text;
}

List<String> splitString(List<String> lista,String text, int start, int end)
{

  
  print(start);
    
    if(end > text.length){

        lista.add(FillOutString(text.substring(start, text.length)));
        return lista;

    }else{

          lista.add(text.substring(start,end));
          lista = splitString(lista, text, start+4, end+4);
    }
  


  return lista;
    

}

void main() {
  Map<String, String> encode = {
    ' ': "11",
    'e': "101",
    't': "1001",
    'o': "10001",
    'n': "10000",
    'a': "011",
    's': "0101",
    'i': "01001",
    'r': "01000",
    'h': "0011",
    'd': "00101",
    'l': "001001",
    '!': "001000",
    'u': "00011",
    'c': "000101",
    'f': "000100",
    'm': "000011",
    'p': "0000101",
    'g': "0000100",
    'w': "0000011",
    'b': "0000010",
    'y': "0000001",
    'v': "00000001",
    'j': "000000001",
    'k': "0000000001",
    'x': "00000000001",
    'q': "000000000001",
    'z': "000000000000"
  };

  // Se pasa la lista y se codifica atravez del map
  //List<String> Text = stdin.readLineSync().toString().split("");
  //String bits = Text.map((char) => TextToBits(encode, char)).toList().join();
  //List<String> ListOfbits = [];
  //ListOfbits = splitString(ListOfbits,bits,0,4);
  //List<String> ListOfHexadecimal = 
  //ListOfbits.map((item) => BitsToHexadecimal(bits)).toList();
  //int num = 2;
  //List<int> nums = [1,2,3];
  
  //nums.forEach((element) { 
    //if(element % 2 == 0){
      //print(element);
    //}

  //});

  //print(bits);
  //print(TextToBits(encode, " "));
  //String hola = "aaaabbbbccccddd";
  //print(hola.substring(8,11));
  //print(hola.substring(8,11).length);
  //print(RellenarString(hola.substring(8,11)));

  //List<String> prueba = [];
  //prueba = splitString(prueba, hola, 0, 4);
  //print(prueba);

  //print(encode[" "]);

  print("hola".contains("hola"));
}

// cat DATA.lst | dart run muelasvill.dart
// 33408 37663 46774 2655 11395 8088 7008 6660 21975 9795 37731 8545 5120 1810
