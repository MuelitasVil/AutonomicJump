def egcd(a, b):
    if a == 0:
        return (b, 0, 1)
    else:
        g, x, y = egcd(b % a, a)
        return (g, y - (b // a) * x, x)

def modinv(b, n):
    g, x, _ = egcd(b, n)
    if g == 1:
        return x % n
    
def crack_unknown_increment(states, modulus, multiplier):
    increment = (states[0]*multiplier) 
    #print("multiplicacion incremento : "+str(increment))
    increment = (states[1] - increment)
    #print("resta incremento : "+str(increment)) 
    increment = increment % modulus
    #print("mod incremento : "+str(increment))
    #print()
    return modulus, multiplier, increment

def crack_unknown_multiplier(states, modulus):
    multiplier = ((states[2] - states[1]) * pow(states[1] - states[0], -1, pow(2, 64))) % modulus
    print("Innverso modular es : "+str(pow(states[1] - states[0], -1, pow(2, 64))))
    return crack_unknown_increment(states, modulus, multiplier)

    
num0 = 12543906180461946496
num1 =  5048678836385112687
num2 = 12532419960800109894
rta = ""
cases = int(input())
for x in range(cases):
    nums = input().split(" ")
    num0 = int(nums[0])
    num1 = int(nums[1])
    num2 = int(nums[2])
    modulus, multiplier, increment = crack_unknown_multiplier([num0, num1, num2], pow(2, 64))
    nextNum = ((num2 * multiplier) + increment) % pow(2, 64)

    print("el multipler es : "+str(multiplier))
    print("el incrmeent es : "+str(increment))
    rta = rta + " "+ str(nextNum)
print(rta)
    
#modulus, multiplier, increment = crack_unknown_multiplier([num0, num1, num2], pow(2, 64))
#nextNum = ((num2 * multiplier) + increment) % pow(2, 64)
#print(pow(2, 64))
#print(num1 - num0)
#print(nextNum)

#print("python M-1 - jq v-1 "+str(15269813291723752991 - 12194083533130134024))
#print(len(str(15269813291723752991)) , " " , len(str(12194083533130134024)))

#print(pow(3,-1,26))

#print(pow(resta, -1, pow(2, 64)))
#print("El modulo es : "+str(modulus))
#print("El multiplciador es : "+str(multiplier))
#print("El incremento es : "+str(increment))
#print(((num2 * multiplier) + increment) % modulus)
