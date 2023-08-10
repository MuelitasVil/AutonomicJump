
void main(){

  String correo;
  String mensaje;

  correo = "Israel123@gmail.com";

  mensaje = correo.contains("gmail") ? "Es un correo " : "No es un correo"; 
  print('$mensaje has ${mensaje.length}');
  print(mensaje);
  

}