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


0000
0001
0002
0003
0004
0005
0006
0007
0008
0009
0010
0011
0012
0013
0014
0015
0016
0017
0018
0019
0020
0021


1000
1100
1110
1111
0001
0011
0111

n000
nn00
