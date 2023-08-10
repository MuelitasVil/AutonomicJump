
number = int(input())
inpt = input().split(" ")

while(inpt[0] != "%"):
    
    operation = inpt[0]
    numbero = int(inpt[1])
    


    if(operation == "+"):
        print("suma")
        number = number + numbero
    elif(operation == "*"):
        print("multuplicacion")
        number = number * numbero 

    print(number)

    inpt = input().split(" ")

print(number % int(inpt[1]))