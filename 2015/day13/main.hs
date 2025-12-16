module Main where

import Data.List

getInput :: IO [(String, String, Integer)]
getInput = do
  file <- readFile "input.txt"
  return $ map ((\x -> (head x, x !! 10, if (x !! 2 == "gain") then read (x !! 3) else -(read (x !! 3)))) . words . init) (lines file)

-- all perms not really needed, will cause some duplicates like reversed orders (same neighbors)
-- but meh, it runs (slowly)
solve :: [(String, String, Integer)] -> Integer
solve input = maximum $ map (sum . concatMap (\names -> map (\(_, _, score) -> score) (filter (\(a, b, _) -> names `elem` [(a, b), (b, a)]) input))) perms
 where
  all_names = (nub . concatMap (\(n1, n2, _) -> [n1, n2])) input
  perms = map (\p -> (last p, head p) : zip p (tail p)) (permutations all_names)

main :: IO ()
main = do
  input <- getInput
  let p1 = solve input
  let all_names = (nub . concatMap (\(n1, n2, _) -> [n1, n2])) input
  let input_p2 = input ++ concatMap (\name -> [("me", name, 0), (name, "me", 0)]) all_names
  let p2 = solve input_p2
  putStrLn $ "Part 1: " ++ show p1
  putStrLn $ "Part 2: " ++ show p2
  return ()
