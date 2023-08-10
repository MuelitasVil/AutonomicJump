import 'dart:io';

int Routesubsub(int max, int num, int cont) {
  //print(num);
  if (num == max || cont == 1000) {
    return num;
  } else {
    num = Routesubsub(max, num + 1, cont + 1);
  }
  return num;
}

int Routesub(int max, int num, int cont) {
  print(num);
  if (num == max || cont == 10000) {
    return num;
  } else {
    num = Routesubsub(max, num + 1, 0);
    num = Routesub(max, num, cont + 1);
  }
  return num;
}

void Route(int max, int num) {
  print(num);
  if (num == max) {
    print(num);
    return;
  } else {
    num = Routesub(max, num, 0);
    Route(max, num);
  }
  return;
}

void main() {
  int cantOfRanges = 21 ~/ 5;
  if (cantOfRanges != 0) {
    cantOfRanges++;
  }
  List<int> Numbers = List.generate(5, (index) => index + 1);
  List<int> Ranges = List.generate(cantOfRanges, (index) => index);
  List<int> EliminarIndices = [];
  print(Ranges);

  int index = 0;
  bool band = true;

  print(Numbers);

  Ranges.forEach((element) {
    
    print(Numbers);
    index = 0;

    if(band){
      Numbers.takeWhile((element) => band).forEach((element) {
      
      if (Numbers[index] + 5 <= 21) {
        Numbers[index] = Numbers[index] + 5;

      } else {
        EliminarIndices.add(element);
      }
  
      index++;
    });
    }
    

    EliminarIndices.forEach((element) {
      band = false;
      Numbers.remove(element);
    });

  });
  
}

// 115920001
// 65373073
// 9542047
// 65906591
// 9610602

// 282429536480