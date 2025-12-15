module Main where
import Data.Char (isAlpha)

main :: IO ()
main = do
    entries <- map (span isAlpha) <$> (lines <$> readFile "../input.txt")
    let pos = ((0,0),0)
    print $ uncurry (*) $ fst $ foldl (flip increase) pos entries

increase :: (String, String) -> ((Integer, Integer), Integer) -> ((Integer, Integer), Integer)
increase (direction, n) ((x,y), aim) =
    let amount = read n :: Integer in
    case direction of
        "forward" -> ((x+amount,y+(amount*aim)),aim)
        "down"    -> ((x,y),aim+amount)
        "up"      -> ((x,y),aim-amount)
        _         -> error "invalid insturction"