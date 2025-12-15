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

def inverse(string):
    inversed = ""
    for i in range(len(string)):
        if string[i] == "0":
            inversed += "1"
        else:
            inversed += "0"
    return inversed

result = []
for i in range (len(bins[0])):
    result.append(common(bins,i,True))

strings = [str(integer) for integer in result]
string = "".join(strings)
print(string)
print(inverse(string))
