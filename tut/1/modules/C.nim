# Module C
import A, B
from B import z
echo A.x
echo B.z

var x = 4
echo x

echo x1(42)
proc x1*(a:int) : string = $(2*a)
echo x1(42)
echo B.x1(42)
