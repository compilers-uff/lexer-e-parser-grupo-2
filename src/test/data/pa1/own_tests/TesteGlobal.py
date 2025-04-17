lista: [int] = None
matriz: [[int]] = None

class _Ameba89(_Ameba88):
    pass

class A(object):
    x: int = 13

    def get10(self: "A") -> int:
        return 10

    def func1(num1: int, num2: int) -> int:
        global numero1
        numero2: int = 11

        def func2():
            nonlocal numero2

            numero3: int = 10

            return 9999 * 67

        return func2()

    def func():
        pass

def buscaBinaria(lista:[int], buscado:int):
    i = len(lista)//2
    while lista[i] != buscado:
        if lista[i] > buscado:
            lista = lista.slice(0, i)
        elif lista[i] < buscado:
            lista = lista.slice(i, -1)

        i = len(lista)//2 
    return i



lista = [1, 2, 3, 13, 20]
i = buscaBinaria(lista, 8989)
if i>=15:
    pass
elif not i and 1:
    for i in lista:
        print("alo")
else:
    print("O cara esta na posicao ", i)
    
i = i*5+10

if True:
    a = -9

print(lista[i*78 %2] is None)
lista = []
lista = []
x = y = 90