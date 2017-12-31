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
