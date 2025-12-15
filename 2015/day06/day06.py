import numpy as np

grid = np.zeros((1000, 1000), dtype=int)
gridp2 = np.zeros((1000, 1000), dtype=int)
with open("input.txt") as f:
    for line in f:
        ins_from, to = line.strip().split(" through ")
        fr = ins_from.split(" ")[-1]
        x1, y1 = map(int, fr.split(","))
        x2, y2 = map(int, to.split(","))
        if "turn off" in line:
            grid[x1 : x2 + 1, y1 : y2 + 1] = 0
            gridp2[x1 : x2 + 1, y1 : y2 + 1] -= 1
            gridp2[gridp2 < 0] = 0
        elif "turn on" in line:
            grid[x1 : x2 + 1, y1 : y2 + 1] = 1
            gridp2[x1 : x2 + 1, y1 : y2 + 1] += 1
        else:
            grid[x1 : x2 + 1, y1 : y2 + 1] = 1 - grid[x1 : x2 + 1, y1 : y2 + 1]
            gridp2[x1 : x2 + 1, y1 : y2 + 1] += 2

print("Part 1:", np.sum(grid))
print("Part 2:", np.sum(gridp2))
