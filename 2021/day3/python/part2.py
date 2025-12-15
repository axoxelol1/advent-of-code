with open("../input.txt") as file:
    bins = file.read().splitlines();

def common(list, index, oxygen):
    nZeros = 0
    nOnes = 0
    for num in range(len(list)):
        if int(list[num][index]) == 0:
            nZeros += 1;
        else:
            nOnes += 1;
    if oxygen: #O2
        if nZeros <= nOnes:
            return 1
        else:
            return 0
    else: #CO2
        if nOnes >= nZeros:
            return 0
        else:
            return 1

last = common(bins, 0, True)
o2 = bins
for bit in range(len(bins[0])):
    mostCommon = common(o2, bit, True)
    o2 = list(filter(lambda c: c[bit] == str(mostCommon), o2))
    if (len(o2)) == 1:
        print(o2)
        break
    

co2 = bins
for bit in range(12):
    leastCommon = common(co2, bit, False)
    co2 = list(filter(lambda c: c[bit] == str(leastCommon), co2))
    if (len(co2)) == 1:
        print(co2)
        break

#strings = [str(integer) for integer in result]
#string = "".join(strings)
#bas10 = int(string)
#num = int(string, 2)