import Data.List (transpose)
main :: IO ()
main = do
    entries <- map toBits <$> (lines <$> readFile "../input.txt")
    let gamma = map (mostCommon . count) (transpose entries)
    let epsilon = map flipBit gamma
    print $ toDec gamma * toDec epsilon

data Bit = One | Zero deriving (Eq, Ord, Show)
data Count = Count {zeros, ones :: Int} deriving Show

toDec :: [Bit] -> Int
toDec = binToDec . bitsToInt 
    where
        binToDec 0 = 0
        binToDec x = 2 * binToDec (div x 10) + mod x 10

bitsToInt :: [Bit] -> Int
bitsToInt = joiner . map toInt 
    where 
        joiner :: [Int] -> Int
        joiner = read . concatMap show

toInt :: Bit -> Int
toInt Zero = 0
toInt One = 1

toBits :: String -> [Bit]
toBits = map toBit

toBit :: Char -> Bit
toBit '0' = Zero
toBit _ = One

toStr :: [Bit] -> String
toStr = map toChar

toChar :: Bit -> Char
toChar Zero = '0'
toChar One = '1'

count :: [Bit] -> Count
count bits = Count (length (filter (== Zero) bits)) (length (filter (== One) bits))

flipBit :: Bit -> Bit
flipBit Zero = One
flipBit One = Zero

mostCommon, leastCommon :: Count -> Bit
mostCommon count
    | ones count > zeros count = One
    | otherwise = Zero

leastCommon = flipBit . mostCommon