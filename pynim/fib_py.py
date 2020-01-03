import time
from fib_nimpy import fib as fib_nim

def fib(n):
    if n <= 2:
        return 1
    else:
        return fib(n-1) + fib(n-2)

if __name__ == "__main__":
    x = 38
    start = time.time()
    res = fib(x)
    elapsed = time.time() - start
    print(f"Python computed fib({x})={res} in {elapsed:3f} seconds")

    start = time.time()
    res = fib_nim(x)
    elapsed = time.time() - start
    print(f"Python+Nim computed fib({x})={res} in {elapsed:3f} seconds")
