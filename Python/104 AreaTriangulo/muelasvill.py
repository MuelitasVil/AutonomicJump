def CalculataDistance(Vertex1, Vertex2):
    Distance = (((Vertex2[0] - Vertex1[0])**2)+((Vertex2[1] - Vertex1[1])**2))**(1/2)
    return Distance

def CaculateArea(Distance1, Distance2, Distance3):
    s = (1/2) * (Distance1 + Distance2 + Distance3)
    return ((s)*(s - Distance1)*(s - Distance2)*(s - Distance3))**(1/2)

NumberOfcases = int(input())
Answer = ""
for x in range(NumberOfcases):
    #data:
    #3
    #1 3 9 5 6 0
    #1 0 0 1 10000 10000
    #7886 5954 9953 2425 6250 2108

    #answer:
    #17 9999.5 6861563
    
    ListOFVertex = input().split(" ")

    VertexA = []
    VertexB = []
    VertexC = []

    VertexA.append(int(ListOFVertex[0]))
    VertexA.append(int(ListOFVertex[1]))

    VertexB.append(int(ListOFVertex[2]))
    VertexB.append(int(ListOFVertex[3]))

    VertexC.append(int(ListOFVertex[4]))
    VertexC.append(int(ListOFVertex[5]))

    DistanceAtoB = CalculataDistance(VertexA, VertexB)
    DistanceAtoC = CalculataDistance(VertexA, VertexC)
    DistanceBtoC = CalculataDistance(VertexB, VertexC)


    Area = CaculateArea(DistanceAtoB, DistanceAtoC, DistanceBtoC)

    Answer = Answer +" "+ str(Area)

print(Answer.strip())