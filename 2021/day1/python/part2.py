with open("../input.txt") as file:
    depths = list(map(int, file.read().splitlines()));

count = 0
for i in range (0, len(depths)-3):
    if depths[i] + depths[i+1] + depths[i+2] < depths[i+1] + depths[i+2] + depths[i+3]:
        count += 1

print(count)