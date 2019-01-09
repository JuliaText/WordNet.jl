using WordNet
using Test

function io_to_string(f::Function)
    buff = IOBuffer()
    f(buff)
    String(take!(buff))
end

include("test_pointer.jl")
include("test_db.jl")
include("test_lemma.jl")
include("test_synset.jl")
include("test_operations.jl")
include("test_sensekeys.jl")
