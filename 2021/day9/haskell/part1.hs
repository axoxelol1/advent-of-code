module Main where
import Data.Char (digitToInt)
import Data.List (transpose)
import Data.Maybe (catMaybes)

type Point = (Int,Int)

main :: IO ()
main = do
    input <- map (map digitToInt) . lines <$> readFile "../input.txt"
    let w = length (head input)
    let h = length input
    let lowPoints = [(r, c) | r <- [0..h-1], c <- [0..w-1], isLowPoint input (r,c)]
    print $ sum [input !! fst lp !! snd lp + 1 | lp <- lowPoints]

isLowPoint :: Ord a => [[a]] -> Point -> Bool
isLowPoint m (r,c) = all (> (m !! r !! c)) (catMaybes [m !!! coords | coords <- neighbours (r,c)])

(!!!) :: [[a]] -> Point -> Maybe a
m !!! (r,c)
    | r < 0 || r >= length m = Nothing
    | c < 0 || c >= length (head m) = Nothing
    | otherwise = Just $ m !! r !! c

neighbours :: Point -> [Point]
neighbours (r,c) = [(r,c-1),(r,c+1),(r-1,c),(r+1,c)]