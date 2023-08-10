// dart compile kernel muelasvill.dart

import 'dart:io';

List<String> GetList(Map<String, List<String>> Cities, String element) {
  List<String> lista = Cities.update(element, (value) => value);
  return lista;
}

List<String> AddElement(List<String> list, String element) {
  list.add(element);
  return list;
}

Map<String, List<String>> CreateCitysWays(List<String> Text) {
  Map<String, List<String>> Cities = {};
  String city = "";
  String conection = "";
  Text.removeAt(0);
  Text.forEach((element) {
    city = element[0];
    conection = element[2];

    if (!Cities.containsKey(city)) {
      Cities[city] = [conection];
    } else {
        Cities.update(city, (value) => AddElement(value, conection));
    }

    if (!Cities.containsKey(conection)) {
      Cities[conection] = [city];
    } else {
        Cities.update(conection, (value) => AddElement(value, city));
      
    }
  });

  return Cities;
}

bool checkCycles(Map<String, List<String>> Cities, String CheckList,
  String ignore, String find) {
  bool cycle = false;
  List<String> ways = GetList(Cities, CheckList);
  int cont = 0;

  ways.takeWhile((element) => !cycle).forEach((element) {
    cont = 0;

    ways.forEach((subelement) {
      if (element == subelement) {
        cont++;
      }
    });

    if (cont > 1) {
      cycle = true;
    }

    if (find == element && element != ignore) {
      cycle = true;
    }

    if (element != ignore && !cycle) {
      cycle = checkCycles(Cities, element, CheckList, find);
    }
  });

  return cycle;
}


String OptimizeCities(int NumsOfTest, int number_test) {
  String rta = "";
  bool optimize = false;

  if (number_test < NumsOfTest) {
    List<String> Text = stdin.readLineSync().toString().split(" ");
    Map<String, List<String>> Cities = CreateCitysWays(Text);


    Cities.entries.takeWhile((value) => !optimize).forEach((element) {
      optimize = checkCycles(Cities, element.key, element.key, element.key);
    });


    if (optimize) {
      rta = "1";
    } else {
      rta = "0";
    }

    rta = rta + " " + OptimizeCities(NumsOfTest, number_test + 1);
  }

  return rta;
}



void main() {
  int CantOfKingdoms = int.parse(stdin.readLineSync().toString());
  print(OptimizeCities(CantOfKingdoms, 0).trim());
  Map<int,int> dic;
}

// cat DATA.lst | dart run muelasvill.dart
// 0 1 1 1 0 0 0 0 0 1 1 1 0 1 0 0 1 1 0 0 0 0 1 0 1

