void main(){

  String function(String a) => "Soy una funcion "+a;


  // Prueba 1 
  List<String> lista = ["Manuel", "Esteban", "Juan"]; 
  List newLista = lista.map((ban) => ban.startsWith("M") ? ban : null).toList();
  print(newLista);

  // Prueba 2 
  List<String> lista2 = ["3", "2", "1"]; 
  List newLista2 = lista.map((ban) => ban.startsWith("M") ? ban : null).toList();
  print(newLista);

}

