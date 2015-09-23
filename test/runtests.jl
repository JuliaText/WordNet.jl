using WordNet
using Compat
using FactCheck

function io_to_string(f::Function) 
    buff = IOBuffer()
    f(buff)
    UTF8String(buff.data)
end

include("test_pointer.jl")
include("test_db.jl")
include("test_lemma.jl")
include("test_synset.jl")
include("test_operations.jl")
