import math

A = 0.59912051 
B = 0.64030348
C = 263.33721367
D = 387.92069617
x = 73.595368554162
print(A * x + B * math.sqrt(pow(x, 3)) - C * math.exp(-x / 50) - D)

print(math.exp(2))
print(math.sqrt(2))

print(0.0000001 - 0.00000001) 
#for x in range(100):
 #   print(x)

#leftPart = (A * x) + (B * math.sqrt(pow(x, 3)))
#print(leftPart)

#rightPart = (C * (math.exp( -1 * (x / 50)))) - D
#print(rightPart)

#print(leftPart - rightPart)