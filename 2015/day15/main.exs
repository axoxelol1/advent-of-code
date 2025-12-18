defmodule Solution do
  def parse_input(file) do
    case File.read(file) do
      {:ok, content} ->
        content
        |> String.split("\n", trim: true)
        |> Enum.map(fn line ->
          Regex.scan(~r/-?\d+/, line)
          |> Enum.flat_map(fn [match] ->
            case Integer.parse(match) do
              {number, _} -> [number]
            end
          end)
        end)

      {:error, reason} ->
        IO.puts("Error reading file: #{reason}")
        []
    end
  end
end

ingredients = Solution.parse_input("input.txt")

p1 =
  Enum.max(
    Stream.flat_map(0..100, fn a ->
      Stream.flat_map(0..(100 - a), fn b ->
        Stream.flat_map(0..(100 - a - b), fn c ->
          d = 100 - a - b - c

          [
            Enum.zip(ingredients, [a, b, c, d])
            |> Enum.map(fn {ing, count} -> Enum.map(ing, fn x -> x * count end) end)
            |> Enum.reduce([0, 0, 0, 0], fn [c, d, f, t, _], [x1, x2, x3, x4] ->
              [x1 + c, x2 + d, x3 + f, x4 + t]
            end)
            |> Enum.reduce(1, fn x, acc -> acc * max(0, x) end)
          ]
        end)
      end)
    end)
  )

p2 =
  Enum.max(
    Stream.flat_map(0..100, fn a ->
      Stream.flat_map(0..(100 - a), fn b ->
        Stream.flat_map(0..(100 - a - b), fn c ->
          d = 100 - a - b - c

          {scores, kcal} =
            Enum.zip(ingredients, [a, b, c, d])
            |> Enum.map(fn {ing, count} -> Enum.map(ing, fn x -> x * count end) end)
            |> Enum.reduce({[0, 0, 0, 0], 0}, fn [c, d, f, t, kcal], {[x1, x2, x3, x4], kc} ->
              {[x1 + c, x2 + d, x3 + f, x4 + t], kc + kcal}
            end)

          if kcal == 500 do
            final_score =
              scores
              |> Enum.map(fn x -> max(0, x) end)
              |> Enum.reduce(1, fn x, acc -> acc * x end)

            [final_score]
          else
            []
          end
        end)
      end)
    end)
  )

IO.write("Part 1: " <> to_string(p1) <> "\n")
IO.write("Part 2: " <> to_string(p2) <> "\n")
