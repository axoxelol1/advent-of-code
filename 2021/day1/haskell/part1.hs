module Main where

main :: IO ()
main = do
    depths <- map (\x -> read x :: Integer) <$> (lines <$> readFile "../input.txt")
    print $ length $ [x | x <- zipWith (<) depths (drop 1 depths), x]