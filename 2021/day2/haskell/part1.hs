module Main where

import Data.Char (isAlpha)

main :: IO ()
main = do
  entries <- map (span isAlpha) <$> (lines <$> readFile "../input.txt")
  let pos = (0, 0)
  print $ uncurry (*) $ foldr increase pos entries

increase :: (String, String) -> (Integer, Integer) -> (Integer, Integer)
increase (direction, n) (x, y) =
  let amount = read n :: Integer
   in case direction of
        "forward" -> (x + amount, y)
        "down" -> (x, y + amount)
        "up" -> (x, y - amount)
        _ -> error "invalid insturction"
