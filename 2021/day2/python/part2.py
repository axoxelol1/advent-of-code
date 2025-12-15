with open("../input.txt") as file:
    instructions = file.read().splitlines();
    
    
pos = [0,0]
aim = 0
for ins in instructions:
    ins = ins.split(" ")
    direction = ins[0]
    amount = int(ins[1])
    if direction == "forward":
        pos[0] += amount
        pos[1] += aim * amount
    if direction == "down":
        aim += amount
    if direction == "up":
        aim -= amount
        
print(pos[0]*pos[1])