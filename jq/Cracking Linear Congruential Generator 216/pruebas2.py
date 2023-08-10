def find_mod_inv(a,m):
 
    for x in range(1,m):
        if((a%m)*(x%m) % m==1):
            return x
    raise Exception("El inverso modular no existe.")
 
#a = 13
#m = 22
 
 # NO SE QUE PASA. DA 60 Y DEBERIA DAR 15 !!! ojo !!! 
 
# Driver Code
if __name__ == "__main__":
    num0 = 16331170523422842635
    num1 =  8023344024804159034
    num2 = 5406677071358476037
    resta = num1 - num0
    #modulus, multiplier, increment = crack_unknown_multiplier([num0,num1,num2], pow(2, 64))

    resta = num2 - num1
    A = resta
    M = pow(2, 64)
 
    # Function call
    print(M) 
 
 
# This code is contributed by Nikita Tiwari.