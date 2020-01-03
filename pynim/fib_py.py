import time

def fib(n):
    if n <= 2:
        return 1
    else:
        return fib(n-1) + fib(n-2)

if __name__ == "__main__":
    x = 36
    start = time.time()
    res = fib(x)
    elapsed = time.time() - start
    print(f"Py3 computed fib({x})={res} in {elapsed:3f} seconds")
