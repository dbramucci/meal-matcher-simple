module Lib
    ( potentialPatrons
    ) where

import qualified Data.Map   as M
import           Data.Maybe (fromMaybe)

type Name = String
type Resturant = String

data Person = Person Name [Resturant]

potentialPatrons :: [Person] -> M.Map Resturant [Person]
potentialPatrons people = foldl addToMap M.empty people
    where addToMap :: M.Map Resturant [Person] -> Person -> M.Map Resturant [Person]
          addToMap m p@(Person name rests) = foldl (\m r -> M.alter (\x -> Just $ p:fromMaybe [] x) r m) m rests

someFunc :: IO ()
someFunc = putStrLn "someFunc"
