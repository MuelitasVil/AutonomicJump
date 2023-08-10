NumberOfcases = int(input()) 
Answer = ""

for x in range(NumberOfcases):
    
    ListOFVertex = input().split(" ")
    WinsOfplayerOne = 0
    WinsOfplayertwo = 0


    for plays in ListOFVertex:
        
        #Wins of player one
        if(plays == "SP"):
            WinsOfplayerOne = WinsOfplayerOne + 1
        elif(plays == "RS"):
            WinsOfplayerOne = WinsOfplayerOne + 1
        elif(plays == "PR"):
            WinsOfplayerOne = WinsOfplayerOne + 1
        
        #Wins of player two
        elif(plays == "PS"):
            WinsOfplayertwo = WinsOfplayertwo + 1
        elif(plays == "SR"):
            WinsOfplayertwo = WinsOfplayertwo + 1
        elif(plays == "RP"):
            WinsOfplayertwo = WinsOfplayertwo + 1

    if(WinsOfplayerOne > WinsOfplayertwo):
        Answer = Answer +" "+ str(1)
    else:
        Answer = Answer +" "+ str(2)

print(Answer.strip())