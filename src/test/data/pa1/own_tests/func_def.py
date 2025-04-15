numero1: int = 10

def func1(num1: int, num2: int) -> int:
    global numero1
    numero2: int = 11

    def func2():
        nonlocal numero2

        numero3: int = 10
