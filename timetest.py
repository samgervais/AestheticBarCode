import itertools
import sys
x = list(itertools.repeat(10000))
print x[int(sys.argv[1])]

y = 1           # f x = x * 2
y = log(x)      # f x =
y = x           # f x = map (*2) [1..x]
y = x**2        # f x = map (map (*2)) (replicate x [1..x])
y = 2**x        # f x = ()
y = x!
