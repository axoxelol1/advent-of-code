module Main where

main :: IO ()
main = do
    depths <- map (\x -> read x :: Integer) <$> (lines <$> readFile "../input.txt")
    let blocks = map sum (chunkList depths)
    print $ length $ [x | x <- zipWith (<) blocks (drop 1 blocks), x]

chunkList [] = []
chunkList list = take 3 list : chunkList (drop 1 list)