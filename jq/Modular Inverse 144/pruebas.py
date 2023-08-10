'''
M A B.

3
71 10 29
57 42 31
36 17 24

mod(A)-1
'''

import math

ans = ""
ncases = int(input())
for x in range(ncases):
    nums = input().split(" ")
    m = int(nums[0])
    a = int(nums[1])
    b = int(nums[2])
    modularInverse = -1 
    if math.gcd(a, m) == 1: 
        modularInverse = pow(a, -1, m)
    ans = ans +" "+ str(modularInverse)
    #print((-b * modularInverse) % m)

print(ans)