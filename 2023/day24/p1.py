from itertools import combinations

type Hailstone = tuple[int, int, int, int, int, int]
hailstones: list[Hailstone] = []

with open("input.txt") as f:
    for line in f:
        pos, vel = line.split("@")
        stone = tuple(map(lambda x: int(x.strip()), pos.split(", ") + vel.split(", ")))
        hailstones.append(stone)

count = 0
for stone1, stone2 in combinations(hailstones, 2):
    x1, y1 = stone1[0], stone1[1]
    x2, y2 = stone1[0] + stone1[3], stone1[1] + stone1[4]
    x3, y3 = stone2[0], stone2[1]
    x4, y4 = stone2[0] + stone2[3], stone2[1] + stone2[4]
    try:
        px = ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) / (
            (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
        )
        py = ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) / (
            (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
        )
    except ZeroDivisionError:
        continue
    is_future1 = (px - x1) * stone1[3] > 0 and (py - y1) * stone1[4] > 0
    is_future2 = (px - x3) * stone2[3] > 0 and (py - y3) * stone2[4] > 0

    if (
        200000000000000 <= px <= 400000000000000
        and 200000000000000 <= py <= 400000000000000
        and is_future1
        and is_future2
    ):
        count += 1

print(f"Part 1: {count}")
