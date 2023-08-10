String DigitstoHexadecimal(int num) {
  String char = "";

  switch (num) {

  case 0: { char = "0"; } break;
  case 1: { char = "1"; } break;
  case 2: { char = "2"; } break;
  case 3: { char = "3"; } break;
  case 4: { char = "4"; } break;
  case 5: { char = "5"; } break;
  case 6: { char = "6"; } break;
  case 7: { char = "7"; } break;
  case 8: { char = "8"; } break;
  case 9: { char = "9"; } break;
  case 10: { char = "A"; } break;
  case 11: { char = "B"; } break;
  case 12: { char = "C"; } break;
  case 13: { char = "D"; } break;
  case 14: { char = "E"; } break;
  case 15: { char = "f"; } break;
  default: {   print("DH : This don't happend"); } break;
  
  }

  return char;
}

int HexadecimaltoDigits(String num) {
  int value = 0;

  switch (num) {
    
  case "0": { value = 0; } break;
  case "1": { value = 1; } break;
  case "2": { value = 2; } break;
  case "3": { value = 3; } break;
  case "4": { value = 4; } break;
  case "5": { value = 5; } break;
  case "6": { value = 6; } break;
  case "7": { value = 7; } break;
  case "8": { value = 8; } break;
  case "9": { value = 9; } break;
  case "A": { value = 10; } break;
  case "B": { value = 11; } break;
  case "C": { value = 12; } break;
  case "D": { value = 13; } break;
  case "E": { value = 14; } break;
  case "F": { value = 15; } break;
  default: {   print("HD : This don't happend"); } break;

  }

  return value;
}
