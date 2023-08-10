import 'dart:io';


bool RemoveTie(String play) {
 
bool Tie = false; 

 switch(play){ 
      
      case "PP": { 
          return true; 

      } 
      break; 
  
      case "SS": { 
          return true; 

      } 
      break; 

      case "RR": { 
          return true;  

      } 
      break; 

  }

  return Tie;

}

bool DefeatOfPlayerOne(String play) {

  bool defeat = false; 

  switch(play){ 
      
      case "PS": { 
          return true; 

      } 
      break; 
  
      case "SR": { 
          return true; 

      } 
      break; 

      case "RP": { 
          return true;  

      } 
      break; 
      

   } 
  
  return defeat;

}

String Game(int NumsOfgame, int number_game) {
  
  int GameWithoutTie = 0;
  int WinsOfplayerOne = 0;
  int WinsOfplayertwo = 0;
  String win = " ";

  List<String> Plays =  stdin.readLineSync().toString().split(" ");
  Plays.removeWhere((element) => RemoveTie(element));
  GameWithoutTie = Plays.length;
  Plays.removeWhere((element) => DefeatOfPlayerOne(element));
  WinsOfplayerOne = Plays.length;
  WinsOfplayertwo = GameWithoutTie - WinsOfplayerOne;

  if(WinsOfplayerOne > WinsOfplayertwo){

    win = "1";
  
  }else{

    win = "2";

  }

  if(number_game < NumsOfgame) {

      win = win + " " + Game(NumsOfgame, number_game + 1);

  }

  return win;

}

void main() {
  
  int NumsOfgame =  int.parse(stdin.readLineSync().toString()); 
  print(Game(NumsOfgame, 1).trim());



}