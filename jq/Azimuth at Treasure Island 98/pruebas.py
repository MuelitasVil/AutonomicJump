import math;

noImporta = input()
entrada = input()

x = 0
y = 0
while(entrada.split(" ")[0] != "Dig"):
    information = entrada.split(" ")
    
    steps = int(information[1])
    grades = int(information[5])
    
    radians = grades *  (math.pi / 180)
    
    x =  x + (steps * math.sin(radians))  
    y =  y + (steps * math.cos(radians))

    print(radians)
    entrada = input()

print(str(x) + " " + str(y))