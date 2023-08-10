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

Map<String, List<String>> CreateCitysWays(
    List<String> Text, int index, Map<String, List<String>> Citiesways) {
  String city = "";
  String conection = "";
  if (index < Text.length) {
    String element = Text[index];
    city = element[0];
    conection = element[2];

    if (!Citiesways.containsKey(city)) {
      Citiesways[city] = [conection];
    } else {
      Citiesways.update(city, (value) => AddElement(value, conection));
    }

    if (!Citiesways.containsKey(conection)) {
      Citiesways[conection] = [city];
    } else {
      Citiesways.update(conection, (value) => AddElement(value, city));
    }

    Citiesways = CreateCitysWays(Text, index + 1, Citiesways);
  }

  return Citiesways;
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

bool TravelCitiesWays(Map<String, List<String>> Cities, List<String> ways,
    String CheckList, String ignore, String find, int index, bool cycle) {
  if (index == ways.length) {
    return cycle;
  }

  if (cycle) {
    return true;
  }

  String element = ways[index];
  int CantWaysCityToCity =
   CyclesOftwoCities(element, ways, ways.length, 0, 0);

  if (CantWaysCityToCity > 1) {
    return true;
  }

  if (element != ignore) {
    if (find == element && element != ignore) {
      return true;
    }

    if (element != ignore && !cycle) {
      cycle = checkCycles(Cities, element, CheckList, find, cycle);
    }
  }

  cycle =
      TravelCitiesWays
      (Cities, ways, CheckList, ignore, find, index + 1, cycle);

  return cycle;
}

bool checkCycles(Map<String, List<String>> Cities, String CheckList,
    String ignore, String find, bool cycle) {
  if (cycle) {
    return true;
  }

  List<String> ways = GetList(Cities, CheckList);
  cycle = TravelCitiesWays(Cities, ways, CheckList, ignore, find, 0, cycle);

  return cycle;
}

bool TravelCities(Map<String, List<String>> Citiesways, List<String> Cities,
    int index, bool optimize) {
  if (index == Cities.length) {
    return optimize;
  }

  optimize = checkCycles(
      Citiesways, Cities[index], Cities[index], Cities[index], false);

  if (optimize) {
    return optimize;
  }

  optimize = TravelCities(Citiesways, Cities, index + 1, optimize);

  return optimize;
}

String OptimizeCities(int NumsOfTest, int number_test) {
  String rta = "";
  bool optimize = false;

  if (number_test < NumsOfTest) {
    List<String> Text = stdin.readLineSync().toString().split(" ");
    Text.removeAt(0);
    Map<String, List<String>> Citiesways = {};
    Citiesways = CreateCitysWays(Text, 0, Citiesways);
    List<String> Cities = Citiesways.keys.toList();

    optimize = TravelCities(Citiesways, Cities, 0, optimize);

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
}

// cat DATA.lst | dart run muelasvill.dart
// 0 1 1 1 0 0 0 0 0 1 1 1 0 1 0 0 1 1 0 0 0 0 1 0 1


