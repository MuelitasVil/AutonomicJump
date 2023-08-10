import 'dart:io';

void EntradaDatos(){

  String? Game =  stdin.readLineSync().toString();

  if(Game.isEmpty){
    print("SE ACABO");
    return;
  }else{
    print("Segimos imprimiedo");
    EntradaDatos();
  }
}

void main() {

EntradaDatos();

}