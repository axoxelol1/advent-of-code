local function countNeighbors(matrix, r, c)
	local count = 0
	for dr = -1, 1 do
		for dc = -1, 1 do
			if not (dr == 0 and dc == 0) then
				local row = matrix[r + dr]
				if row and row[c + dc] then
					count = count + 1
				end
			end
		end
	end
	return count
end

local function aliveCount(matrix)
	local alive = 0
	for r = 1, #matrix do
		for c = 1, #matrix[r] do
			if matrix[r][c] then
				alive = alive + 1
			end
		end
	end
	return alive
end

local file, err = io.open("input.txt", "r")
if not file or err then
	print("Cannot open input")
	return
end
local input = file:read("*all")
file:close()

local matrix = {}
for line in input:gmatch("[^\n]+") do
	local row = {}
	for char in line:gmatch(".") do
		table.insert(row, char == "#")
	end
	table.insert(matrix, row)
end

for _ = 1, 100 do
	local nextMatrix = {}
	for r = 1, #matrix do
		nextMatrix[r] = {}
		for c = 1, #matrix[r] do
			local neighbors = countNeighbors(matrix, r, c)
			if matrix[r][c] then
				nextMatrix[r][c] = (neighbors == 2 or neighbors == 3)
			else
				nextMatrix[r][c] = (neighbors == 3)
			end
		end
	end

	matrix = nextMatrix
end

print("Part 1: " .. aliveCount(matrix))

matrix = {}
for line in input:gmatch("[^\n]+") do
	local row = {}
	for char in line:gmatch(".") do
		table.insert(row, char == "#")
	end
	table.insert(matrix, row)
end

matrix[1][1] = true
matrix[1][100] = true
matrix[100][1] = true
matrix[100][100] = true

for _ = 1, 100 do
	local nextMatrix = {}
	for r = 1, #matrix do
		nextMatrix[r] = {}
		for c = 1, #matrix[r] do
			local neighbors = countNeighbors(matrix, r, c)
			if matrix[r][c] then
				nextMatrix[r][c] = (neighbors == 2 or neighbors == 3)
			else
				nextMatrix[r][c] = (neighbors == 3)
			end
		end
	end
	nextMatrix[1][1] = true
	nextMatrix[1][100] = true
	nextMatrix[100][1] = true
	nextMatrix[100][100] = true
	matrix = nextMatrix
end

print("Part 2: " .. aliveCount(matrix))
