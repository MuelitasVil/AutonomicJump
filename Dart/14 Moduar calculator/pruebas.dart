import 'dart:io';
void main(){


    List<String> Operation =  stdin.readLineSync().toString().split(" ");
    int calculation = 0;

    switch(Operation[0]){ 
      
      case "+": { 

          print("suma");

      } 
      break; 
  
      case "*": { 
          
          print("multiplicacion");

      } 
      break; 

      case "%": { 
          
          print("mod");

      } 
      break; 
      
   } 

}