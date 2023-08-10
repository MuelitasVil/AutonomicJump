String SumOfDigits(List<int> num, int indice){
   

  int? Sumatoria = num[0] * indice;
  num.removeAt(0);

  if(!num.isEmpty){

    Sumatoria = Sumatoria + int.parse(SumOfDigits(num, indice + 1));
    
  }
  
  return Sumatoria.toString();

}

void main(){

    
    print(SumOfDigits([1,7,7,6], 1));

    
}