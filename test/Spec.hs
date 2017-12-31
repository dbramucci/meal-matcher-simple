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
    where setEqual a b = S.fromList a == S.fromList b
