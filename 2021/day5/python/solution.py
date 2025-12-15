import numpy as np

def get_pairs(start, end, diag): #Don't like it but too tired to rewrite
    (x0,y0) = start
    (x1,y1) = end
    if (x0 < x1):
        xs = [x for x in range(x0, x1 + 1, 1)]
    else:
        xs = [x for x in range(x0, x1 - 1, -1)]
    if (y0 < y1):
        ys = [y for y in range(y0, y1 + 1, 1)]
    else:
        ys = [y for y in range(y0, y1 - 1, -1)]
    if (x0 == x1 or y0 == y1):
        return [(x,y) for x in xs for y in ys]
    else:
        if not diag:
            return []
        result = []
        for i in range(len(xs)):
            result.append((xs[i], ys[i]))
        return result

with open("../input.txt") as file:
    input = file.read().splitlines()
    lines = map(lambda range: range.split(' -> '), input)

def main():
    board = {}
    for line in lines:
        start = tuple(list(map(int, line[0].split(','))))
        end = tuple(list(map(int, (line[1].split(',')))))
        pairs = get_pairs(start, end, True)
        for pair in pairs:
            if not pair in board:
                board[pair] = 0
            board[pair] += 1

    count = 0
    for points in board.values():
        if points >= 2:
            count += 1
    print(count)
    
main()