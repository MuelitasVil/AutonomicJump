import urllib.request
from os import remove


def StringArchivo(number):
        
        numeroArchivo = ""

        if(number< 10):
            numeroArchivo = "00"+str(number)
        elif(number < 100):
            numeroArchivo = "0"+str(number)
        else:
            numeroArchivo = str(number)

        return numeroArchivo

def OrganizarYEliminarLinksDañados():
    numeroArchivo = ""
    for x in range(1, 302):
        OrganizarArchivoOthers(x)
       
 
def OrganizarArchivoOthers(numero):
        print(numero)
        numeroArchivo = StringArchivo(numero)

        try:
            ListaUrl = []
            contador = 0
            Direccion = "C:\\Users\\mmart\\OneDrive\\Escritorio\\AutonomicJump\\challenges\\code\\codeabbey\\{}\\OTHERS.lst".format(numeroArchivo)

            archivo = open(Direccion)
            linea=archivo.readline()
            print("Se abrio el archivo {} Others.lst ".format(numeroArchivo))

            while linea != '':
                UrlEliminadas = False
                linea=archivo.readline()
                try:
                    datos = urllib.request.urlopen(linea)
                except:
                    UrlEliminadas = True
                    contador = contador + 1 
                
                if(UrlEliminadas == False):
                    ListaUrl.append(linea)
            
            print("Se han eliminado {} url's del archivo Other.lst {} ".format(contador, numeroArchivo))
                

            ListaUrl.reverse()
            archivo.close()
            remove(Direccion)

            archivo = open(Direccion,"w")

            while(len(ListaUrl) > 0):
                archivo.write("{}".format(ListaUrl.pop(0)))
            
            print("Se organizo con exito el archivo {} Others.lst ".format(numeroArchivo))


        except:
            print("El archivo {}\others.lst no existe".format(numeroArchivo))


def EliminarLink(numero, link):
        print(numero)
        numeroArchivo = StringArchivo(numero)

        try:
            ListaUrl = []
            contador = 0
            Direccion = "C:\\Users\\mmart\\OneDrive\\Escritorio\\AutonomicJump\\challenges\\code\\codeabbey\\{}\\OTHERS.lst".format(numeroArchivo)

            archivo = open(Direccion)
            linea=archivo.readline()
            print("Se abrio el archivo {} Others.lst ".format(numeroArchivo))

            while linea != '':
                UrlEliminadas = False
                linea=archivo.readline()
                try:
                    datos = urllib.request.urlopen(linea)
                except:
                    UrlEliminadas = True
                    contador = contador + 1 
                
                if(UrlEliminadas == False and linea != link):
                    ListaUrl.append(linea)
            
            print("Se han eliminado {} url's del archivo Other.lst {} ".format(contador, numeroArchivo))
                

            ListaUrl.reverse()
            archivo.close()
            remove(Direccion)

            archivo = open(Direccion,"w")

            while(len(ListaUrl) > 0):
                archivo.write("{}".format(ListaUrl.pop(0)))
            
            print("Se organizo con exito el archivo {} Others.lst ".format(numeroArchivo))


        except:
            print("El archivo {}\others.lst no existe".format(numeroArchivo))


OrganizarYEliminarLinksDañados()


