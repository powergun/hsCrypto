# Rolling your Own Blockchain in Haskell

source: <http://www.michaelburge.us/2017/08/17/rolling-your-own-blockchain.html>

## Merkle tree

source: <https://selfkey.org/what-is-a-merkle-tree-and-how-does-it-affect-blockchain-technology/>

> MerkleF is a higher-order Merkle tree type that adds a layer onto some other type. The Cofree MerkleF Block does two things: It recursively applies MerkleF to produce a type for all depths of Merkle trees, and it attaches an annotation of type Block to each node in the tree.
> When using Cofree, anno :< xf will construct one of these annotated values.

(why using MerkleF)

> The main reason is to get those Functor, Traversable, and Foldable instances, because we can use them to work with our Merkle tree without having to write any code.

(on hashing the blockchain data structure)

> Crypto.Hash has plenty of ways to hash something, and we’ve chosen type HaskoinHash = Digest SHA1 earlier. But in order to use it, we need some actual bytes to hash. That means we need a way to serialize and deserialize a Blockchain. A common library to do that is binary, which provides a Binary typeclass that we’ll implement for our types.

MY NOTES: see hsAlgorithms/hashings for a simple example using a binary tree
