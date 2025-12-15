module Main where
import Data.List.Split ( splitOn )
import Data.List ( sort )

-- Compile with O2 argument or it will be too slow

input :: IO [Int]
input = sort . map (read :: String -> Int) . splitOn "," <$> readFile "../input.txt"

part1 :: IO ()
part1 = do
    crabs <- input
    print $ minimum $ map (howMuchFuel crabs) [minimum crabs..maximum crabs]
        where howMuchFuel crabs target = sum [abs (crab - target) | crab <- crabs]

part2 :: IO ()
part2 = do
    crabs <- input
    print $ minimum $ map (howMuchFuel crabs) [minimum crabs..maximum crabs]
        where 
            howMuchFuel crabs target = sum [sum [0..abs (crab - target)] | crab <- crabs]

main :: IO ()
main = do
    part1
    part2