module Main where
import Text.Parsec
import Text.Parsec.Combinator
import Data.Either
import Data.List
import Data.Maybe

data Cell = Cell {
    number :: Int,
    marked :: Bool
} deriving Show

type Bingo = [[Cell]]

printBingo :: Bingo -> IO ()
printBingo bingo = do
    let ints = map (map number) bingo
    mapM_ print ints


parseBingos :: [String] -> [Bingo]
parseBingos list = bingo $ map (map (read :: String -> Int) . words) list
    where
        bingo [] = []
        bingo rows = map (map (`Cell` False)) (take 5 rows) : bingo (drop 5 rows)

commaSep = many (noneOf ",") `sepBy` char ','

hasWon :: Bingo -> Bool
hasWon bingo =
    any and (marks ++ transpose marks)
        where marks = map (map marked) bingo

updateBingo :: Bingo -> Int -> Bingo
updateBingo [] _ = []
updateBingo bingo int = updateRow (head bingo) int : updateBingo (drop 1 bingo) int

updateRow :: [Cell] -> Int -> [Cell]
updateRow [] _ = []
updateRow row int = updateCell (head row) int : updateRow (drop 1 row) int

updateCell :: Cell -> Int -> Cell
updateCell cell num =
    if number cell == num
        then Cell (number cell) True
        else Cell (number cell) (marked cell)

winner :: [Bingo] -> [Int] -> (Bingo, Int)
winner bingos [] = error "No winner"
winner bingos nums =
    if any hasWon updatedBingos
        then (fromJust $ find hasWon updatedBingos, head nums)
        else winner updatedBingos (drop 1 nums)
        where
            updatedBingos = map (`updateBingo` head nums) bingos

-- unmarkedSum :: Bingo -> Int
-- unmarkedSum :: [[Cell]] -> [[Cell]]
unmarkedSum bingo =
    sum $ map sum onlyMarked
        where
            onlyMarked = map (map number . filter (not . marked)) bingo

main :: IO ()
main = do
    input <- filter (/= "") . lines <$> readFile "../input.txt"
    let drawn = map (read :: String -> Int) $ fromRight (error "parse drawn failed") (parse commaSep "" (head input))
    let bingos = parseBingos (drop 1 input)
    let w = winner bingos drawn
    print $ unmarkedSum (fst w) * snd w 