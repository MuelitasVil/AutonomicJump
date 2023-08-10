number1 = "?942682966937054"
number = ""
for x in range(len(number1) -1 , -1 , -1 ):
    number = number + number1[x]

print(number) 
sum = 0
for x in range(len(number)):
    print(number[x], end=" : ")
    if number[x] != "?":
        if x % 2 == 0:
            sum = sum + (int(number[x]))
        else:
            if int(number[x]) < 5:
                sum = sum + (int(number[x]) * 2)
            else:
                sum = sum + ((int(number[x]) * 2) - 9)

    print(sum)
print(sum) 