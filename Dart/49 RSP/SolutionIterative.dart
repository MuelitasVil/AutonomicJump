import 'dart:io';


void main() {
  
int WinsOfplayerOne = 0;
int WinsOfplayertwo = 0;
int NumberOfGames = 0;

String GamesIn = stdin.readLineSync().toString();
NumberOfGames = int.parse(GamesIn);
String Answer = "";


  for(int i = 0; i < NumberOfGames; i++){

    WinsOfplayerOne = 0;
    WinsOfplayertwo = 0;

    String Game = stdin.readLineSync().toString();
    List<String> plays = Game.split(" ");

    for (final play in plays) {
    

     if(play == "SP"){
      WinsOfplayerOne = WinsOfplayerOne + 1;
     }else if(play == "RS"){
      WinsOfplayerOne = WinsOfplayerOne + 1;
     }else if(play == "PR"){
      WinsOfplayerOne = WinsOfplayerOne + 1;

      }else if(play == "PS"){
      WinsOfplayertwo = WinsOfplayertwo + 1;
     }else if(play == "SR"){
      WinsOfplayertwo = WinsOfplayertwo + 1;
     }else if(play == "RP"){
      WinsOfplayertwo = WinsOfplayertwo + 1;
     }           

  }
  
  if(WinsOfplayerOne > WinsOfplayertwo){
        Answer = Answer +" 1";
    }else{
        Answer = Answer +" 2";
    }

  }


print(Answer.trim());

}
