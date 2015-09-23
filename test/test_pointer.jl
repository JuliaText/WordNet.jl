facts("Pointer") do
    context("constructor") do 
        pointer = WordNet.Pointer("s", 123, 'v', "1234")

        @fact pointer.sym    --> "s"
        @fact pointer.offset --> 123
        @fact pointer.pos    --> 'v'
        @fact pointer.source --> "12"
        @fact pointer.target --> "34"
    end

    context("is not semantic for non-0") do 
        ptr = WordNet.Pointer("s", 123, 'v', "1234")
        @fact WordNet.is_semantic(ptr) --> false
    end

    context("is semantic for all-0") do 
        ptr = WordNet.Pointer("s", 123, 'v', "0000")
        @fact WordNet.is_semantic(ptr) --> true
    end
end
