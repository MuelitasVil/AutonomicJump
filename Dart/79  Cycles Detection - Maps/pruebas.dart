// dart compile kernel muelasvill.dart

import 'dart:io';

List<String> GetList(Map<String, List<String>> Cities, String element) {
  List<String> lista = Cities.update(element, (value) => value);
  return lista;
}

List<String> AddElement(List<String> list, String element) {
  list.add(element);
  //print(list);
  return list;
}

Map<String, List<String>> CreateCitysWays(List<String> Text) {
  Map<String, List<String>> Cities = {};
  String city = "";
  String conection = "";
  Text.removeAt(0);
  //print(Text);
  Text.forEach((element) {
    city = element[0];
    conection = element[2];

    if (!Cities.containsKey(city)) {
      //print("$city : $conection");
      Cities[city] = [conection];
    } else {
      Cities.update(city, (value) => AddElement(value, conection));
      //print("$city : $conection");

    }

    if (!Cities.containsKey(conection)) {
      //print("$city : $conection");
      Cities[conection] = [city];
    } else {
      //print("$city : $conection");
      Cities.update(conection, (value) => AddElement(value, city));
    }
  });

  return Cities;
}

int CyclesOftwoCities(
    String citie, List<String> ways, int lengthOfWays, int cont, int index) {
  if (index == lengthOfWays) {
    return cont;
  }

  if (citie == ways[index]) {
    cont++;
  }

  cont = CyclesOftwoCities(citie, ways, lengthOfWays, cont, index + 1);

  return cont;
}

bool TravelCities(Map<String, List<String>> Cities, List<String> ways,
    String CheckList, String ignore, String find, int index, bool cycle) {
  
  if(index == ways.length){
    return cycle;
  }

  if (cycle) {
    return true;
  }

  String element = ways[index];
  print("ways[$index] = $element");
  int CantWaysCityToCity = CyclesOftwoCities(element, ways, ways.length, 0, 0);

  if (element != ignore) {
    if (CantWaysCityToCity > 1) {
      return true;
    }

    if (find == element && element != ignore) {
      return true;
    }

    if (element != ignore && !cycle) {
      print("Ingreso  a los ways de $element");
      cycle = checkCycles(Cities, element, CheckList, find, cycle);
    }
  }

  cycle = TravelCities(Cities, ways, CheckList, ignore, find, index + 1, cycle);

  return cycle;
}

bool checkCycles(Map<String, List<String>> Cities, String CheckList,
    String ignore, String find, bool cycle) {
  if (cycle) {
    return true;
  }

  List<String> ways = GetList(Cities, CheckList);
  print("$CheckList : $ways");
  cycle = TravelCities(Cities, ways, CheckList, ignore, find, 0, cycle);

  return cycle;
}

void main() {
  // Caso falla :
  // 1 T-J Y-J K-T B-Y X-Y W-T T-W -> Se espera 1 sale 0 Arreglado
  // 2 P-F I-P D-F R-F Z-I E-F J-Z Y-F I-P -> Se espera 1 sale 0 Arreglado
  // 8 Z-T U-T K-U P-U G-Z W-G B-G G-Z
  List<String> Text = stdin.readLineSync().toString().toLowerCase().split(" ");
  //print(Text);
  bool cycles = false;
  Map<String, List<String>> Cities = CreateCitysWays(Text);
  //print("Ingresamos al abismo ;");
  Cities.forEach((key, value) {
    print("$key : $value");
  });

  print("Ingreso a comprobar los caminos");

  Cities.entries.takeWhile((value) => !cycles).forEach((element) {
    cycles = checkCycles(Cities, element.key, element.key, element.key, false);
  });
  print(cycles);

  /*
  
  3
  3 A-B B-C B-D
  4 A-B B-D D-C A-C
  4 A-B B-C C-A A-D

  */
  // 3 A-B B-C B-D

  /*
  8 Z-T U-T K-U P-U G-Z W-G B-G G-Z
  Z : [T, G]
  T : [Z, U]
  U : [T, K, P]
  K : [U]
  P : [U]
  G : [Z, W, B]
  W : [G]
  B : [G]
  false
  */

  //Map<String, List<String>> Citys = {};
  //List<String> hola = [];
  //Citys["h"] = ["a"];
  //Citys.forEach((key, value) {print("$key : $value");});
}

// cat DATA.lst | dart run muelasvill.dart
// 09 18 97 0E 28 82 60 13 73 18 44 34 8A 01 18 61 40
