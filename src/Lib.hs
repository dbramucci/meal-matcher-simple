module Lib where

import           Data.List  (sortOn)
import qualified Data.Map   as M
import           Data.Maybe (fromMaybe)

type Name = String
type Resturant = String
type Plan = M.Map Resturant [Name]

data Person = Person Name [Resturant] deriving Show

potentialPatrons :: [Person] -> Plan
potentialPatrons = foldl perPerson M.empty
    where perPerson :: Plan -> Person -> Plan
          perPerson m (Person name rests) = foldl (perResturant name) m rests

          perResturant :: Name -> Plan -> Resturant -> Plan
          perResturant name = flip $ M.alter (\x -> Just $ name:fromMaybe [] x)

filterOutSingles :: [Person] -> [Person]
filterOutSingles people = people'
    where people' :: [Person]
          people' = map (\(Person name rests) -> Person name (filter (\r -> M.notMember r onePersonRest) rests)) people

          onePersonRest :: Plan
          onePersonRest = M.filter (\patrons -> length patrons == 1) (potentialPatrons people)

possibleAnswers :: [Person] -> [Plan]
possibleAnswers [] = [M.empty]
possibleAnswers (Person _ []:people) = possibleAnswers people -- Ignore people with no resturant to go to.
possibleAnswers (p:people) = do
  let Person name rests = p
  r <- rests
  ans <- possibleAnswers people
  return $ M.alter (\x -> Just $ name:fromMaybe [] x) r ans

bestSolutions :: [Person] -> [Plan]
bestSolutions people = case allSolutions of
                           [] -> []
                           first:_ -> let n = numberOfHappy first in takeWhile (\x
                            -> numberOfHappy x == n) allSolutions
  where allSolutions = reverse . sortOn numberOfHappy .
                       possibleAnswers . filterOutSingles $ people

numberOfHappy :: Plan -> Int
numberOfHappy = M.foldl' (\s x -> if length x > 1 then s + length x else s) 0
