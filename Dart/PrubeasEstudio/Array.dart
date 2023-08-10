void main(){

  List<String> lista  = ["hola", "juan", "roberto"];
  List NuevaLista = lista.where((alumno) => alumno.startsWith("h")).toList();

  print(lista);
  print(NuevaLista);

  print("-----------------");
  lista.removeAt(0);
  print(lista);

  // Remove where 

    int number = 2; 
    List<int> numeros2 = [1, 2, 3];
    List<int> NuevaLista2 = numeros2.map((num) => num == number ? 100 : 0).toList();
    print("esto me interesa -----------------");
    print(NuevaLista2);
    List<int> NuevaLista3 = numeros2.map((num) => 10).toList();
    print(NuevaLista3);
  
    NuevaLista2.removeWhere((element) => element == 0);

    List<int> numeros = [1, 2, 3, 4];
    numeros.removeWhere((element) => element == 2);

    List<String> numbers = ['one', 'two', 'three', 'four'];
    numbers.removeWhere((item) => item.length == 3);
    print(numbers.join(', ')); // 'three, four'
    
    // Ejemplo Take while para parar un forecha
      //lista.takeWhile((element) => ! (element == 2)  
      //? band = true : band = false).forEach((element) { 
      //print(element);
   //});
  
  /*

  bool band = true; 
  lista.takeWhile((value) => band).forEach((element) { 
    print(element);
    if(element == 2){
      band = false;
    }
  
  });
  
  */
  print("Redecue : ");
  bool band = true;
  List<int> Numbers = [0, 1, 2, 1, 2, 3, 2, 3, 4];
        int CantOfLuckyNumbers = Numbers.reduce((value, element) => band
          ? value + (element * element)
          : value + value + (element * element * 3));
  print(CantOfLuckyNumbers);
  // Generar un arreglo 
  //List<int> Numbers = List.generate(max, (index) => index + 1);

}