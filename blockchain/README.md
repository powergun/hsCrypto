# Rolling your Own Blockchain in Haskell

source: <http://www.michaelburge.us/2017/08/17/rolling-your-own-blockchain.html>

## Merkle tree

source: <https://selfkey.org/what-is-a-merkle-tree-and-how-does-it-affect-blockchain-technology/>

> MerkleF is a higher-order Merkle tree type that adds a layer onto some other type. The Cofree MerkleF Block does two things: It recursively applies MerkleF to produce a type for all depths of Merkle trees, and it attaches an annotation of type Block to each node in the tree.
> When using Cofree, anno :< xf will construct one of these annotated values.

(why using MerkleF)

> The main reason is to get those Functor, Traversable, and Foldable instances, because we can use them to work with our Merkle tree without having to write any code.
