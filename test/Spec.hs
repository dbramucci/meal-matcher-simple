import qualified Data.Map        as M
import qualified Data.Set        as S
import           Lib
import           Test.Hspec
import           Test.QuickCheck

main :: IO ()
main = hspec $ do
    describe "Find best plans" $ do
        it "One person has no valid plan" $ do
            property $ \n r -> bestSolutions [Person n r] `setEqual` [M.empty]
        it "Two people with no resturants in common have an empty plan." $ do
            property $ \n1 r1 n2 r2 ->
              S.intersection (S.fromList r1) (S.fromList r2) == S.empty ==>
              bestSolutions [Person n1 r1, Person n2 r2] `setEqual` [M.empty]
        it "Two people with one resturants in common will \
            \go to that resturant" $ do
             property $ \n1 r1 n2 r2 c->
               S.intersection (S.fromList r1) (S.fromList r2) == S.empty ==>
               let sol = bestSolutions [Person n1 (c:r1), Person n2 (c:r2)]
               in sol `setEqual` [M.fromList [(c, [n1, n2])]] ||
                  sol `setEqual` [M.fromList [(c, [n2, n1])]]
    describe "Possible Bugs" $ do
        it "One person can't go if they list their choice twice" $ do
            bestSolutions [Person "Bob" ["IHOP", "IHOP"]] `setEqual` [M.empty]
            `shouldBe` True
        it "This shouldn't fail this case mean towards greedy algorithms" $ do
            bestSolutions [Person "Catherine" ["Taco Bell"]
                         , Person "Bruce" ["McDonalds", "Taco Bell"]
                         , Person "Adam" ["McDonalds"]
                         , Person "Ellis" ["Taco Bell", "Long John Silvers"]
                         , Person "Ferris" ["Long John Silvers"]
                         , Person "Geralt" ["Long John Silvers"]]
                         `setEqual` [M.fromList [
                              ("Long John Silvers", ["Ferris", "Geralt"])
                            , ("McDonalds", ["Bruce","Adam"])
                            , ("Taco Bell", ["Catherine", "Ellis"])
                            ]]
            `shouldBe` True
    where setEqual a b = S.fromList a == S.fromList b
