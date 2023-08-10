A = 445
C = 700001
M = 2097152
X0 = 2014 

for x in range(9):
    X0 = ((X0 * A) + C) % M
    print("i : "+str(x))
    print("Numero aleatorio : "+str(X0))
    if x == 0: 
        print("cons Numero aleatorio : "+str(X0 % 19))
    else:
        print("cons Numero aleatorio : "+str(X0 % 5))