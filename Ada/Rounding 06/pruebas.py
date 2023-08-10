 
divisor = 4422852
dividendo = -8249728
maxModulo = divisor - 1

mitadMod = (maxModulo // 2) 
division = dividendo / divisor
mod = dividendo % divisor
print("La division es :")
print(division)
print("max mod")
print(maxModulo)
print("Mitad mod : ")
print(mitadMod)
print("Modulo : ")
print(mod)

if (mod > mitadMod):
    print((dividendo // divisor) + 1) 
else:
    print(dividendo // divisor) 
# 6 
#0   0.0
#1   0.16666666666666666
#2   0.3333333333333333
#3   0.5
#4   0.6666666666666666
#5   0.8333333333333334

# 7 
#0   0.0
#1   0.14285714285714285
#2   0.2857142857142857
#3   0.42857142857142855
#4   0.5714285714285714
#5   0.7142857142857143
#6   0.8571428571428571