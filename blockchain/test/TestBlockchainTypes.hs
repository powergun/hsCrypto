{-# LANGUAGE NoImplicitPrelude #-}

module TestBlockchainTypes where

import           Blockchain.Types
import           Control.Comonad.Cofree (Cofree (..))
import qualified Data.Vector            as V
import           Protolude

import           Test.Hspec

demo = runTests

runTests :: IO ()
runTests = hspec $ do
  describe "Construct a chain from scratch" $ do
    it "Retrieve all transactions" $ do
      let genesis_block = Block (V.fromList ([] :: [Transaction]))
          block1 = Block (V.fromList [Transaction 0 1 1000])
          genesis_chain = genesis_block :< Genesis  -- MerkleF
          chain1 = block1 :< Node (BlockHeader {_miner = 0, _parentHash = undefined }) genesis_chain
          chain2 = block1 :< Node (BlockHeader {_miner = 0, _parentHash = undefined }) chain1
      let transactions = toList . mconcat . toList $ chain2
      length transactions `shouldBe` 2
