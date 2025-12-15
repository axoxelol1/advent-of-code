module Main where

main :: IO ()
main = do
    ls <- lines <$> readFile "../input.txt"
    print . sum . map tableLookup . filter (/= 'n') . map corrChar $ ls

tableLookup :: Char -> Int
tableLookup ')' = 3
tableLookup ']' = 57
tableLookup '}' = 1197
tableLookup '>' = 25137
tableLookup _ = error "Not valid corrchar"

-- | Returns first corrupted char or 'n' if not corrupted
corrChar :: [Char] -> Char
corrChar line = corr line []
    where
        corr :: [Char] -> [Char] -> Char
        corr [] stack         = 'n'
        corr (p:ps) stack
            | open p = corr ps (p:stack)
            | pair (head stack, p) = corr ps (drop 1 stack)
            | otherwise = p

open :: Char -> Bool
open c = c `elem` ['[','(','{','<']

pair :: (Char,Char) -> Bool
pair ('[',']') = True
pair ('(',')') = True
pair ('{','}') = True
pair ('<','>') = True
pair _ = False