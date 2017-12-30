module Lib
    ( potentialPatrons
    ) where

import qualified Data.Map   as M
import           Data.Maybe (fromMaybe)

type Name = String
type Resturant = String

data Person = Person Name [Resturant]

potentialPatrons :: [Person] -> M.Map Resturant [Person]
potentialPatrons = foldl perPerson M.empty
    where perPerson :: M.Map Resturant [Person] -> Person -> M.Map Resturant [Person]
          perPerson m p@(Person _ rests) = foldl (perResturant p) m rests
          perResturant :: Person -> M.Map Resturant [Person] -> Resturant -> M.Map Resturant [Person]
          perResturant p = flip $ M.alter (\x -> Just $ p:fromMaybe [] x)
