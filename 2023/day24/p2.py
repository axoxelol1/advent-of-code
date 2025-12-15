from z3 import Int, Solver

type Hailstone = tuple[int, int, int, int, int, int]
hailstones: list[Hailstone] = []

with open("input.txt") as f:
    for line in f:
        pos, vel = line.split("@")
        stone = tuple(map(lambda x: int(x.strip()), pos.split(", ") + vel.split(", ")))
        hailstones.append(stone)

s = Solver()
x, y, z, dx, dy, dz = Int("x"), Int("y"), Int("z"), Int("dx"), Int("dy"), Int("dz")
for i, stone in enumerate(hailstones):
    time = Int(f"t{i}")
    sx, sy, sz, sdx, sdy, sdz = stone
    s.add(time >= 0)
    s.add(x + dx * time == sx + sdx * time)
    s.add(y + dy * time == sy + sdy * time)
    s.add(z + dz * time == sz + sdz * time)


s.check()
print(s.model()[x].as_long() + s.model()[y].as_long() + s.model()[z].as_long())
