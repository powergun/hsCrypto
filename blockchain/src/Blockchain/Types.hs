{-# LANGUAGE DeriveDataTypeable         #-}
{-# LANGUAGE DeriveTraversable          #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE TypeSynonymInstances       #-}

module Blockchain.Types where

import           Control.Comonad.Cofree
import           Crypto.Hash
import           Data.Data
import qualified Data.Vector            as V
import           Protolude

newtype Account = Account Integer
                  deriving (Eq, Show, Num, Ord)

data Transaction = Transaction
  { _from   :: Account
  , _to     :: Account
  , _amount :: Integer
  } deriving (Eq, Show)

newtype BlockF a = Block (V.Vector a)
                   deriving ( Eq, Show, Foldable, Traversable
                            , Functor, Semigroup, Monoid)

type Block = BlockF Transaction

type BlockchainHash = Digest SHA1

data BlockHeader = BlockHeader
  { _miner      :: Account
  , _parentHash :: BlockchainHash
  } deriving (Eq, Show)

data MerkleF a = Genesis
               | Node BlockHeader a
               deriving (Eq, Show, Functor, Traversable, Foldable)

{-
Cofree

source: https://hackage.haskell.org/package/free-5.1.3/docs/Control-Comonad-Cofree.html#v::-60-
-}
type Blockchain = Cofree MerkleF Block
