module Blockchain.Mining where

import           Blockchain.Types

import           Control.Comonad.Cofree (Cofree (..))
import qualified Data.Vector            as V

type TransactionPool = IO [Transaction]

makeGenesis :: IO Blockchain
makeGenesis =
  let empty_ = [] :: [Transaction]
      genesis_ = Block (V.fromList empty_) :< Genesis
  in return genesis_

mineOn :: TransactionPool -> Account -> Blockchain -> IO Blockchain
mineOn pendingTransactions minerAccount parent = do
  ts <- pendingTransactions
  let block = Block . V.fromList $ ts
      header = BlockHeader { _miner = minerAccount
                           , _parentHash = hash parent
                           }
  return $ block :< Node header parent

hash :: Blockchain -> BlockchainHash
hash = undefined
