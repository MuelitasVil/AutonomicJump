def GenerarMaximo(digitos, exponente):
    exponente = str(exponente-1)
    return int(digitos * (exponente))

def GenerarDiguitos(digitos, exponente):
    max = GenerarMaximo(digitos, exponente)
    for x in range(max):
        

print(GenerarMaximo(4, 3))
    