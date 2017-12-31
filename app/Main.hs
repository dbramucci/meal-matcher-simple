module Main where

import           Control.Monad   (mapM_, replicateM)
import           Data.Char       (isSpace)
import           Data.List       (intercalate)
import           Data.List.Split (splitOn)
import qualified Data.Map        as M
import           Lib

main :: IO ()
main = do
   people <- readPeople
   let res = bestSolutions people
   mapM_ printSolution res

printSolution :: Plan -> IO ()
printSolution sol = do
    putStrLn "Solution: "
    mapM_ printResturant (M.toList sol)


printResturant :: (Resturant, [Name]) -> IO ()
printResturant (res, names) = do
    putStr $ res ++ ": "
    putStrLn $ intercalate ", " names

readPeople :: IO [Person]
readPeople = do
    numberOfPeople <- read <$> getLine
    replicateM numberOfPeople $ do
        raw <- getLine
        let [name, resturantsRaw] = trim <$> splitOn ":" raw
        let resturants = trim <$> splitOn "," resturantsRaw
        return $ Person name resturants
  where trim :: String -> String
        trim = f . f
           where f = reverse . dropWhile isSpace
