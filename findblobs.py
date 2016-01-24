from math import *
arr = [[0,0,0,0,0,0,0,0,0,0,0,0,0],
       [0,0,0,0,1,0,0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0,1,1,1,0,0,0],
       [0,0,0,0,0,0,1,1,0,1,0,0,0],
       [0,0,0,0,0,0,0,1,1,1,0,0,0],
       [0,0,1,1,0,0,0,0,0,0,0,0,0],
       [0,0,1,0,0,0,0,0,0,0,0,0,0],
       [0,0,0,1,0,0,0,0,0,0,0,0,0]]


indexes = [(4,1), (8,2), (3,8), (10,10)]
arr = [[0,0,0,0,0,0,0,0,0,0,0,0,0],
       [0,0,0,0,2,0,0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0,3,3,3,0,0,0],
       [0,0,0,0,0,0,3,3,0,3,0,0,0],
       [0,0,0,0,0,0,0,3,3,3,0,0,0],
       [0,0,4,4,0,0,0,0,0,0,0,0,0],
       [0,0,4,0,0,0,0,0,0,0,0,0,0],
       [0,0,0,5,0,0,0,0,0,0,0,0,0]]


def printArr(arr):
    for row in arr:
        for x in row:
            if x == 1:
                print '#',
            else:
                print ' ',
        print '\n'

# arr = map(lambda row: map(lambda x: abs(x - 1), row), arr)

def checkAround(xss,index):
    x,y = index
    blobIndexes = []
    if (xss[y+1][x] == 1):
        blobIndexes.append((x,y+1))
    if (xss[y][x+1] == 1):
        blobIndexes.append((x+1,y))
    return blobIndexes

def findBlob(xss, index):
    x,y = index
    blobIndexes = []
    while somecondition:
        checkAround

print checkAround(arr,(7,2))
