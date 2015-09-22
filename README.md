# WordNet

[![Build Status](https://travis-ci.org/jbn/WordNet.jl.svg?branch=master)](https://travis-ci.org/jbn/WordNet.jl)
[![Coverage Status](https://coveralls.io/repos/jbn/WordNet.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/jbn/WordNet.jl?branch=master)

A Julia package for using Princeton's [WordNet](https://wordnet.princeton.edu/)®, heavily inspired by  
 [Douches](https://github.com/doches)' [rwordnet](https://github.com/doches/rwordnet).

## Design consideration

This package loads all of WordNet into memory. It's not terribly expensive, but it may not be suitable for all developers. 

## Wordnet Data

I don't include the data in this repository. Ignoring copyright concerns, I dislike big chunks of data in my `.julia/vX.X` directory. Something about it worries me. To use this library, you must download and install version 3.0 of WordNet. Download it [here](http://wordnetcode.princeton.edu/3.0/WNdb-3.0.tar.gz). Then, decompress it. The resulting directory is the one to use when constructing a `Worknet.DB` type.

> George A. Miller (1995). WordNet: A Lexical Database for English. 
> Communications of the ACM Vol. 38, No. 11: 39-41. 
