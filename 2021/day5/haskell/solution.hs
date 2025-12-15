module Main where
import Data.List.Split
import qualified Data.HashMap as HM

type Point = (Int, Int)
data Line = Line Point Point
    deriving (Show, Eq)

-- | Gives all poitns on a line, 
--   if second argument is false it ignores diagonals
getPoints :: Line -> Bool -> [Point]
getPoints (Line (x0, y0) (x1, y1)) includeDiags
    | x0 == x1 || y0 == y1 = [(x, y) | x <- xs, y <- ys]
    | includeDiags = [(xs !! i, ys !! i) | i <- [0..(length xs - 1)]]
    | otherwise = []
        where
            xs = if x0 < x1 then [x0..x1] else [x0,x0-1..x1]
            ys = if y0 < y1 then [y0..y1] else [y0,y0-1..y1]


nIntersect :: [Point] -> HM.Map Point Int
nIntersect ps = calc ps HM.empty
    where
        calc [] map = map
        calc (p:ps) map = calc ps (HM.insertWith (\n o -> o+1) p 1 map)

main :: IO ()
main = do
    input <- readFile "../input.txt"
    -- Unreadable but fun with oneliner, can be split up
    let points = concatMap ((`getPoints` True) . (\ps -> Line (head ps) (last ps)) 
            . map ((\s -> (read $ head s, read $ last s)) . splitOn ",")
                . filter (/= "->") . words) (lines input)
    print $ length $ HM.filter (>= 2) $ nIntersect points