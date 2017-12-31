module Lib where

import           Data.List  (sortOn)
import qualified Data.Map   as M
import           Data.Maybe (fromMaybe)

type Name = String
type Resturant = String

data Person = Person Name [Resturant] deriving Show

potentialPatrons :: [Person] -> M.Map Resturant [Name]
potentialPatrons = foldl perPerson M.empty
    where perPerson :: M.Map Resturant [Name] -> Person -> M.Map Resturant [Name]
          perPerson m (Person name rests) = foldl (perResturant name) m rests

          perResturant :: Name -> M.Map Resturant [Name] -> Resturant -> M.Map Resturant [Name]
          perResturant name = flip $ M.alter (\x -> Just $ name:fromMaybe [] x)

filterOutSingles :: [Person] -> [Person]
filterOutSingles people = people'
    where people' :: [Person]
          people' = map (\(Person name rests) -> Person name (filter (\r -> M.notMember r onePersonRest) rests)) people

          onePersonRest :: M.Map Resturant [Name]
          onePersonRest = M.filter (\patrons -> length patrons == 1) (potentialPatrons people)

possibleAnswers :: [Person] -> [M.Map Resturant [Name]]
possibleAnswers [] = [M.empty]
possibleAnswers (Person _ []:people) = possibleAnswers people -- Ignore people with no resturant to go to.
possibleAnswers (p:people) = do
  let Person name rests = p
  r <- rests
  ans <- possibleAnswers people
  return $ M.alter (\x -> Just $ name:fromMaybe [] x) r ans

bestSolutions :: [Person] -> [M.Map Resturant [Name]]
bestSolutions people = case allSolutions of
                           [] -> []
                           first:_ -> let n = numberOfHappy first in takeWhile (\x
                            -> numberOfHappy x == n) allSolutions
  where allSolutions = reverse . sortOn numberOfHappy .
                       possibleAnswers . filterOutSingles $ people

numberOfHappy :: M.Map Resturant [Name] -> Int
numberOfHappy = M.foldl' (\s x -> if length x > 1 then s + length x else s) 0
