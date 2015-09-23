# WordNet

[![Build Status](https://travis-ci.org/jbn/WordNet.jl.svg?branch=master)](https://travis-ci.org/jbn/WordNet.jl)
[![Coverage Status](https://coveralls.io/repos/jbn/WordNet.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/jbn/WordNet.jl?branch=master)
[![Build status](https://ci.appveyor.com/api/projects/status/bpqbdf24thkp6ytw/branch/master?svg=true)](https://ci.appveyor.com/project/jbn/wordnet-jl/branch/master)

A Julia package for using Princeton's [WordNet](https://wordnet.princeton.edu/)®, heavily inspired by [Douches](https://github.com/doches)' [rwordnet](https://github.com/doches/rwordnet).

## Simple Demo

```juila
using WordNet
db = DB("/Users/generativist/Data/WordNet/")
```
> WordNet.DB

```juila
lemma = db['a', "glad"]
```
> glad.a

```julia
ss = synsets(db, lemma)
```
> 4-element Array{WordNet.Synset,1}:  
> (a) glad (showing or causing joy and pleasure; especially made happy; "glad you are here"; "glad that they succeeded"; "gave a glad shout"; "a glad smile"; "heard the glad news"; "a glad occasion")   
> (s) happy, glad (eagerly disposed to act or to be of service; "glad to help")    
> (s) glad (feeling happy appreciation; "glad of the fire's warmth")                                                                 
> (s) glad, beaming (cheerful and bright; "a beaming smile"; "a glad May morning")  

```julia
antonym(db, ss[1])
```
> 1-element Array{WordNet.Synset,1}:  
> (a) sad (experiencing or showing sorrow or unhappiness; "feeling sad because his dog had died"; "Better by far that you should forget and smile / Than that you should remember and be sad"- Christina Rossetti)

```julia
expanded_hypernym(db, synsets(db, db['n', "DOG"])[1])
```
> 13-element Array{WordNet.Synset,1}:  
> (n) canine, canid (any of various fissiped mammals with nonretractile claws and typically long muzzles)  
> (n) carnivore (a terrestrial or aquatic flesh-eating mammal; "terrestrial carnivores have four or five clawed digits on each limb")  
> (n) eutherian mammal, placental, placental mammal, eutherian (mammals having a placenta; all mammals except monotremes and marsupials)  
> (n) mammalian, mammal (any warm-blooded vertebrate having the skin more or less covered with hair; young are born alive except for the small subclass of monotremes and nourished with milk)
> (n) vertebrate, craniate (animals having a bony or cartilaginous skeleton with a segmented spinal column and a large brain enclosed in a skull or cranium)
> (n) chordate (any animal of the phylum Chordata having a notochord or spinal column)  
> (n) animal, creature, animate being, brute, beast, fauna (a living organism characterized by voluntary movement)
> (n) organism, being (a living thing that has (or can develop) the ability to act or function independently)
> (n) living thing, animate thing (a living (or once living) entity) 
>  (n) unit, whole (an assemblage of parts that is regarded as a single entity; "how big is that part compared to the whole?"; "the team is a unit")  
> (n) physical object, object (a tangible and visible entity; an entity that can cast a shadow; "it was full of rackets, balls and other objects")  
> (n) physical entity (an entity that has physical existence)  
> (n) entity (that which is perceived or known or inferred to have its own distinct existence (living or nonliving))


## Design consideration

This package loads all of WordNet into memory. It's not terribly expensive, but it may not be suitable for all developers. 

## Wordnet Data

I don't include the data in this repository. Ignoring copyright concerns, I dislike big chunks of data in my `.julia/vX.X` directory. Something about it worries me. To use this library, you must download and install version 3.0 of WordNet. Download it [here](http://wordnetcode.princeton.edu/3.0/WNdb-3.0.tar.gz). Then, decompress it. The resulting directory is the one to use when constructing a `Worknet.DB` type.

> George A. Miller (1995). WordNet: A Lexical Database for English. 
> Communications of the ACM Vol. 38, No. 11: 39-41. 
