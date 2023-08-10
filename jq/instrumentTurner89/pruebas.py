import math

base = 16.352
Buscar = 185.4

distancia = 12 * math.log((Buscar/base),2) # Asi hayo la distancia entre el incio y la nota en hz
nota = distancia % 12
NumeroOctava = (distancia / 12) % 11

print(-1 * math.log((0.385),2))
print("La distancia de la nota es {}".format(distancia))
print("El numero de la nota es {}".format(nota + 1))
print("El numero de la octavaes {}".format(NumeroOctava))


