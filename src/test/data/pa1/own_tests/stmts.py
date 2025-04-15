lista: [int] = None
lista = [1, 2, 3, 13, 20]

buscado = 13

i = len(lista)//2
while lista[i] != buscado:
    if lista[i] > buscado:
        lista = lista.slice(0, i)
    elif lista[i] < buscado:
        lista = lista.slice(i, -1)

    i = len(lista)//2

print("O cara esta na posicao ", i)