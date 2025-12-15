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
    if direction == "down":
        pos[1] += amount
    if direction == "up":
        pos[1] -= amount
        
print(pos[0]*pos[1])