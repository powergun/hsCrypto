{-# LANGUAGE NoImplicitPrelude #-}

module TestBlockchainMining (demo) where

import           Blockchain.Mining
import           Blockchain.Serialization
import           Blockchain.Types

import qualified Crypto.Hash                 as CH
import qualified Data.ByteString.Base16.Lazy as BSL

import           Protolude

testMining :: IO Blockchain
testMining = do
  let txnPool = return []
  chain <- makeGenesis
  chain <- mineOn txnPool 0 chain
  chain <- mineOn txnPool 0 chain
  chain <- mineOn txnPool 0 chain
  chain <- mineOn txnPool 0 chain
  chain <- mineOn txnPool 0 chain
  return chain

demo :: IO ()
demo = do
  chain <- testMining
  let h = (CH.hashlazy . encode $ chain) :: BlockchainHash
      eh = BSL.encode . encode $ chain

  -- for testing purpose, I can use base16 encoding instead of hashing algorithm
  -- reference: https://hackage.haskell.org/package/base16-bytestring
  print eh

  print h
