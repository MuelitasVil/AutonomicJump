chars = "0123456789ABCDEFGHIJKLMNOPQRSTUV"

for x in range(len(chars)):
    print(chars[x], end= " : ") 
    print(format(x, "b"))
    