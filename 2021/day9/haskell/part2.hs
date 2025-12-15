module Main where
import Data.Char (digitToInt)
import qualified Data.Matrix as M
import Data.Maybe (mapMaybe, catMaybes)
import Maybes (isJust)
import Data.List (sort)

type Point = (Int,Int)

data MyList a = Nil | Cons a (MyList a)

main :: IO ()
main = do
    input <- map (map digitToInt) . lines <$> readFile "../input.txt"
    let w = length (head input)
    let h = length input
    let lowPoints = [(r, c) | r <- [0..h-1], c <- [0..w-1], isLowPoint input (r,c)]
    print . product . take 3 . reverse . sort . map (basinSize input) $ lowPoints

isLowPoint :: Ord a => [[a]] -> Point -> Bool
isLowPoint m (r,c) = all (> (m !! r !! c)) (catMaybes [m !!! coords | coords <- neighbours (r,c)])

(!!!) :: [[a]] -> Point -> Maybe a
m !!! (r,c)
    | r < 0 || r >= length m = Nothing
    | c < 0 || c >= length (head m) = Nothing
    | otherwise = Just $ m !! r !! c

neighbours :: Point -> [Point]
neighbours (r,c) = [(r,c-1),(r,c+1),(r-1,c),(r+1,c)]

basinSize :: [[Int]] -> Point -> Int
basinSize m (r,c) = length $ basin [(r,c)] []
    where
        basin :: [Point] -> [Point] -> [Point]
        basin [] acc = acc
        basin (p:ps) acc = basin (ps ++ [n | n <- neighbours p, m !!! n `notElem` [Just 9, Nothing], n `notElem` (acc ++ ps)]) (p : acc)