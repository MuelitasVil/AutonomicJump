
casos = int(input())
respuesta = ""
for x in range(casos):
    info = input().split(" ")

    piernas = int(info[0])
    senos = int(info[1])

    PiernasCerdos = 4
    PiernasChicas = 2 

    maxCerdos = piernas // PiernasCerdos
    minChicas = (piernas % PiernasCerdos) // 2

    if (piernas % PiernasCerdos) == 0:
        maxCerdos = maxCerdos - 1
        minChicas = 2
    
    print(maxCerdos)
    print(minChicas)
    
    listaPiernas = []

    while(maxCerdos >= 1):

        listaPiernas.append([maxCerdos, minChicas])

        maxCerdos = maxCerdos - 1 
        minChicas = minChicas + 2

    listaSenosMujeres = []
    

 
    for par in listaPiernas:
        print(par)
        listaSenosMujeres.append([par[0],par[1],(par[1] * 2)])

    listaFinal = []
    for trio in listaSenosMujeres:
        print(trio)
        if ((senos - trio[2]) % trio[0]) == 0 and ((senos - trio[2]) // trio[0])  % 2 == 0:
            listaFinal.append(trio)

    for info in listaFinal:
        print(info)
    
    respuesta = respuesta + " "+ str(len(listaFinal))

print(respuesta)
    
#Respuseta : 13 14 30 4 6 17 3 5 10 2 3 4 25