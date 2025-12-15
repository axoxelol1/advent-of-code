module Main where
import Data.List (sort)

main :: IO ()
main = do
    ls <- lines <$> readFile "../input.txt"
    let scores = map (calcScore . (map closer . snd)) . filter (null . fst) . map process $ ls
    print $ sort scores !! (length scores `div` 2)

calcScore :: [Char] -> Int
calcScore ps = calc ps 0
    where
        calc [] score = score
        calc (p:ps) score = calc ps (score*5+tableLookup p)

tableLookup :: Char -> Int
tableLookup ')' = 1
tableLookup ']' = 2
tableLookup '}' = 3
tableLookup '>' = 4
tableLookup _   = error "not valid close"

process :: [Char] -> ([Char],[Char])
process line = proc line []
    where
        proc :: [Char] -> [Char] -> ([Char],[Char])
        proc [] stack         = ([], stack)
        proc l@(p:ps) stack
            | open p = proc ps (p:stack)
            | pair (head stack, p) = proc ps (drop 1 stack)
            | otherwise = (l, stack)

open :: Char -> Bool
open c = c `elem` ['[','(','{','<']

closer :: Char -> Char
closer '[' = ']'
closer '(' = ')'
closer '{' = '}'
closer '<' = '>'
closer _ = error "Not valid open"

pair :: (Char,Char) -> Bool
pair ('[',']') = True
pair ('(',')') = True
pair ('{','}') = True
pair ('<','>') = True
pair _ = False