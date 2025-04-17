def badFunction(x int -> int  # erro: falta de dois-pontos e parênteses mal fechados
    y = x + 1
    return y

class Person:
    def __init__(self, name: str, age: int)
        self.name = name
        self.age = age

    def greet(self) -> str:
        return "Hello, my name is " + self.name + "." + " I am " + self.age + " years old"  # erro: concatenação com int

x: int = "texto"  # erro: atribuição de string em variável do tipo int

if x = 10:  # erro: operador de atribuição usado em vez de comparação
    print("x is ten")

while x < 5  # erro: falta de dois-pontos
    x = x + 1

def anotherFunction(x: int, y: int) -> int:
    return x + y + z  # erro: z não definido
