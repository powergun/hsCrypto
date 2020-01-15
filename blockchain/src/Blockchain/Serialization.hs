{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE TypeSynonymInstances       #-}
{-# LANGUAGE UndecidableInstances       #-}

module Blockchain.Serialization (encode, decode) where

import           Blockchain.Types

import           Control.Comonad.Cofree
import           Crypto.Hash
import           Data.Binary
import           Data.Binary.Get
import           Data.ByteArray
import qualified Data.ByteString        as BS
import qualified Data.ByteString.Lazy   as BSL
import           Data.Vector.Binary
import           GHC.Generics

instance (Binary (f (Cofree f a)), Binary a) => Binary (Cofree f a) where
instance (Binary a) => Binary (MerkleF a) where
instance Binary BlockHeader where
instance Binary Transaction where
deriving instance Binary Account
deriving instance Binary Block

-- deriving instance Generic (Cofree f a)
deriving instance Generic (MerkleF a)
deriving instance Generic BlockHeader
deriving instance Generic Transaction

{-
source: https://hackage.haskell.org/package/binary-0.10.0.0/docs/Data-Binary.html#t:Binary

class Binary t where

The Binary class provides put and get, methods to encode and decode
a Haskell value to a lazy ByteString. It mirrors the Read and Show
classes for textual representation of Haskell types, and is suitable
for serialising Haskell values to disk, over the network.
-}
instance Binary BlockchainHash where
  get = do
    mDigest <- digestFromByteString <$> (get :: Get BS.ByteString)
    case mDigest of
      Nothing     -> fail "Not a valid digest"
      Just digest -> return digest
  put digest = put $ (convert digest :: BS.ByteString)

deserialize :: BSL.ByteString -> Blockchain
deserialize = decode

serialize :: Blockchain -> BSL.ByteString
serialize = encode
