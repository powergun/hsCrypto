{-# LANGUAGE NoImplicitPrelude #-}

module Blockchain.Mining where

import           Blockchain.Serialization
import           Blockchain.Types

import           Control.Comonad.Cofree
import           Crypto.Hash
import           Data.Binary
import qualified Data.Map                 as M
import qualified Data.Vector              as V

import           Protolude

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
                           , _parentHash = hashlazy . encode $ parent
                           }
  return $ block :< Node header parent

blockReward = 1000

headers :: Blockchain -> [BlockHeader]
headers (_ :< Genesis)     = []
headers (_ :< Node x next) = x : headers next

balances :: Blockchain -> M.Map Account Integer
balances bc =
  let txns = toList $ mconcat $ toList bc
      debits = map (\Transaction{ _from = acc, _amount = amount} -> (acc, -amount)) txns
      credits = map (\Transaction{ _to = acc, _amount = amount} -> (acc, amount)) txns
      minings = map (\h -> (_miner h, blockReward)) $ headers bc
  in M.fromListWith (+) $ debits ++ credits ++ minings

validTransactions :: Blockchain -> [Transaction] -> [Transaction]
validTransactions bc txns =
  let accounts = balances bc
      validTxn txn = case M.lookup (_from txn) accounts of
        Nothing      -> False
        Just balance -> balance >= _amount txn
  in filter validTxn txns
