day1 = 1
hour1 = 0 
min1 = 0
second1 = 0

day2 = 2
hour2 = 3 
min2 = 4
second2 = 5

TotalSecond1 = (day1 * 86400) + (hour1 * 3600) + (min1 * 60) + second1
TotalSecond2 = (day2 * 86400) + (hour2 * 3600) + (min2 * 60) + second2

print(TotalSecond1)
print(TotalSecond2)
secondsDiference = TotalSecond2 - TotalSecond1
print(secondsDiference)
