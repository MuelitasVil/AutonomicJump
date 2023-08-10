import 'dart:io';

void WhileP(int max, int num){

  //print(num);
  if(num == max){
    //print("Se logro");
    return; 
  }else{
    WhileP(max, num+1);
  }
  return;
}

void WhileF(int max, int num){
  
  if(num == max){
    print(num);
    return;
  }else{
    WhileP(10000, 0);
    WhileF(max, num+1);
  }
  return;
}
void main(){
  
  int max = 10;
  List<int> Numbers = List.generate(max~/2, (index) => index + 1);
  print(Numbers);
  List<int> Numbers2 = List.generate(max~/2, (index) => index + max~/2);
  print(Numbers2);
}