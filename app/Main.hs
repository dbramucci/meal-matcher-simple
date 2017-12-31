module Main where

import           Control.Monad   (mapM_, replicateM)
import           Data.Char       (isSpace)
import           Data.List       (intercalate)
import           Data.List.Split (splitOn)
import qualified Data.Map        as M
import           Lib

t = [Person "Danny" ["TB", "BK"],
     Person "Sarah" ["TB"],
     Person "Cham" ["TB", "BK", "5G"],
     Person "Joe"   ["BK"],
     Person "Sisu"  ["5G"],
     Person "Bob"   ["5G", "TB"]]

t3 = [Person "Danny" ["TB", "BK"],
    Person "Sarah" ["TB"],
    Person "Cham" ["TB", "BK"],
    Person "Joe"  ["BK"]]

t2 = Person "Cham" (map show [1..1000]) : map (\x -> Person (show x) [show x]) [1..1000]

printSolution :: M.Map Resturant [Name] -> IO ()
printSolution sol = do
    putStrLn "Solution: "
    mapM_ printResturant (M.toList sol)


printResturant :: (Resturant, [Name]) -> IO ()
printResturant (res, names) = do
    putStr $ res ++ ": "
    putStrLn $ intercalate ", " names

readInput :: IO [Person]
readInput = do
  numberOfPeople <- read <$> getLine
  replicateM numberOfPeople $ do
    raw <- getLine
    let [name, resturantsRaw] = trim <$> splitOn ":" raw
    let resturants = trim <$> splitOn "," resturantsRaw
    return $ Person name resturants
  where
    trim :: String -> String
    trim = f . f
       where f = reverse . dropWhile isSpace



main :: IO ()
main = do
   people <- readInput
   let res = bestSolutions people
   mapM_ printSolution res
