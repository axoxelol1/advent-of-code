module Main where

import Data.List

getInput :: IO [(String, String, Integer)]
getInput = do
  file <- readFile "example.txt"
  return $ map ((\x -> (head x, x !! 10, read (x !! 3))) . words . init) (lines file)

main :: IO ()
main = do
  input <- getInput
  let names = (nub . concatMap (\(n1, n2, _) -> [n1, n2])) input
  let p1 = (maximum . map . permutations) names
  return ()
