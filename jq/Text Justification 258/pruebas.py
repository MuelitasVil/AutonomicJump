'''
input:

23
Four score and seven years ago
our fathers brought forth,
upon this continent, a new nation, conceived in
liberty and dedicated to the proposition
that all men are created equal.

answer:

Four  score  and  seven
years  ago our  fathers
brought   forth,   upon
this  continent,  a new
nation,   conceived  in
liberty  and  dedicated
to the proposition that
all  men  are   created
equal.

'''

#primero vamos a unir todo el texto en una sola linea 

maxcar = 15
caracteres = ""
palabra = "foravanad zibecefeb wagabenip wedivonow"
lista = palabra.split(" ")

for x in lista:
    caracteres = caracteres + x

cantOfchar = len(caracteres)
cantOfwords = len(lista)
print("tam palabra "+str(len(palabra)))
print("chars : "+str(cantOfchar))
print("max - chars : "+str(maxcar - cantOfchar))
print("Palabras : "+str(len(lista)))

'''

lista = []
while True:
    inputs = input()
    if inputs:
        lista.append(inputs)
    else:
        break
print(lista)

'''
