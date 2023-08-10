import os
from os import remove

archivo = open("C:\\Users\\mmart\\OneDrive\\Escritorio\\Estudiar\\Codeabby\\Python\\Organizar y comprobar urls\OTHERS.lst","w")
archivo.write("hola\n")
archivo.write("hola\n")
archivo.write("hola\n")
archivo.write("hola\n")
archivo.write("hola\n")
archivo.write("hola\n")

lista = []
for x in range(10):
    lista.append(x)

for x in range(10):
    print(lista.pop(0))
    
print("vacio : ")
for x in lista:
    print(lista)