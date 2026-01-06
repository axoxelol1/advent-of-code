using Combinatorics

function solve(input, num_groups)
  possible = Array{Int64}[]
  for i in 1:length(input)
    found = false
    for comb in combinations(input, i)
      if sum(comb) == sum(input) ÷ num_groups
        push!(possible, comb)
        found = true
      end
    end
    if found
      break
    end
  end

  return minimum(prod.(possible))
end

input = parse.(Int64, readlines("input.txt"))

p1 = solve(input, 3)
println("Part 1: $p1")

p2 = solve(input, 4)
println("Part 2: $p2")
