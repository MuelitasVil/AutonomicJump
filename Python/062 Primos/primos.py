def Esprimo(num):
    for x in range(2, int(num**(1/2)+1)):
        if(num % x == 0):
            return False
    return True

def ImprimirPrimos(x, y):
    cont = 0
    for x in range(x, y+1):
        if(Esprimo(x)):
            print(x)
            cont = cont + 1
    print(cont) 

ImprimirPrimos(1, 100)