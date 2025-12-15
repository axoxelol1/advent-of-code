module Main where
import Data.List.Split (splitOn)
import Data.List (find, intersect, concatMap)
import Data.Maybe (fromJust)

segToNum :: [String] -> String -> Int
segToNum hints seg
    | len == 2 = 1
    | len == 3 = 7
    | len == 4 = 4
    | len == 7 = 8
    | len == 5 && overlap 1 == 2 = 3
    | len == 5 && overlap 4 == 3 = 5
    | len == 5 = 2
    | len == 6 && overlap 1 == 1 = 6
    | len == 6 && overlap 4 == 4 = 9
    | len == 6 = 0
    | otherwise = -1
        where
            len = length seg
            r' :: Int -> String -> String
            r' len s = s `intersect` fromJust (find (\x -> length x == len) hints)
            overlap :: Int -> Int
            overlap 1 = length $ r' 2 seg
            overlap 4 = length $ r' 4 seg
            overlap 7 = length $ r' 3 seg
            overlap 8 = length $ r' 7 seg
            overlap _ = error "Illegal overlap call, only 1 4 7 8"
            
main :: IO ()
main = do
    ls <- lines <$> readFile "../input.txt"
    let input = map ((\pair -> (words (head pair), words (last pair))) . splitOn " | ") ls
    print $ sum $ map (((read :: String -> Int) . concatMap show) . (\(hints,segs) -> map (segToNum hints) segs)) input