
import qualified TestBlockchainMining
import qualified TestBlockchainTypes

main :: IO ()
main = do
  TestBlockchainTypes.demo
  TestBlockchainMining.demo
