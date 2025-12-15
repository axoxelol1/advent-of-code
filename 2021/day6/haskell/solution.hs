module Main where
import Data.List.Split

runCycle :: [Int] -> Int -> [Int]
runCycle fish 0 = fish
runCycle fish n = runCycle (age fish) (n-1)
    where
        age fish = drop 1 (take 7 fish) ++ [head fish + fish !! 7, fish !! 8, head fish]

main :: IO()
main = do
    input <- map (read :: String -> Int) . splitOn "," <$> readFile "../input.txt"
    let day0 = [length (filter (==i) input) | i <- [0..8]]
    print $ sum $ runCycle day0 256