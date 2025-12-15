module Main where
import Data.List ( sort )
import Data.List.Split ( splitOn )
-- I did not come up with this, but wanted to document a proper solution

input :: IO [Int]
input = sort . map (read :: String -> Int) . splitOn "," <$> readFile "../input.txt"

part1 :: IO ()
part1 = do
    crabs <- input
    let target = crabs !! (length crabs `div` 2)
    print $ sum [abs (crab - target) | crab <- crabs]

part2 :: IO ()
part2 = do
    crabs <- input 
    let avg = sum crabs `div` length crabs
    print $ minimum [sum [sum [0..abs (crab - target)] | crab <- crabs] | target <- [avg, avg+1]]

main :: IO ()
main = do
    part1
    part2