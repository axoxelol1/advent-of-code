module Main where
import Data.List.Split (splitOn)

main :: IO ()
main = do
    ls <- lines <$> readFile "../input.txt"
    let input = map ((\pair -> (words (head pair), words (last pair))) . splitOn " | ") ls
    print $ length $ concatMap (filter (/= -1) . map segsToNum . snd) input
    where
    segsToNum str
        | len == 2 = 1
        | len == 3 = 7
        | len == 4 = 4
        | len == 7 = 8
        | otherwise = -1
            where len = length str