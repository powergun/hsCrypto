{-# LANGUAGE NoImplicitPrelude #-}

module TestBlockchainTypes where

import           Blockchain.Types
import qualified Data.Vector      as V
import           Protolude

demo :: IO ()
demo = do
  let genesis_block = Block (V.fromList [])
  return ()
