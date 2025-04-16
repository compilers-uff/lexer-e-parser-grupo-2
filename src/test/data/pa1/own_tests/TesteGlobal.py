class A(object):
    x: int = 13
    def get(self: A) -> int:
        return self.x

lista: [int] = None
lista = [1, 2, 3, 13, 20]

buscado = A().x

def func1(num1: int, num2: int) -> int:
    global numero1
    numero2: int = 11

    def func2():
        nonlocal numero2

        numero3: int = 10

        return numero3

    return func2()


def buscaBinaria(lista:[int], buscado:int):
    i = len(lista)//2
    while lista[i] != buscado:
        if lista[i] > buscado:
            lista = lista.slice(0, i)
        elif lista[i] < buscado:
            lista = lista.slice(i, -1)

        i = len(lista)//2 
    return i



i = buscaBinaria(lista, buscado)

if (i==0 or i==15):
    pass
else:
    print("O cara esta na posicao ", i)
    
i = i*5+10
