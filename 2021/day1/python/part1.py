with open("../input.txt") as file:
    depths = list(map(int, file.read().splitlines()));

count = 0
for i in range(len(depths)-1):
    if depths[i] < depths[i+1]:
        count += 1
        
print(count)