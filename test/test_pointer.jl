@testset "Pointer" begin
    @testset "constructor" begin
        pointer = WordNet.Pointer("s", 123, 'v', "1234")

        @test pointer.sym    == "s"
        @test pointer.offset == 123
        @test pointer.pos    == 'v'
        @test pointer.source == "12"
        @test pointer.target == "34"
    end

    @testset "is not semantic for non-0" begin
        ptr = WordNet.Pointer("s", 123, 'v', "1234")
        @test WordNet.is_semantic(ptr) == false
    end

    @testset "is semantic for all-0" begin
        ptr = WordNet.Pointer("s", 123, 'v', "0000")
        @test WordNet.is_semantic(ptr) == true
    end
end
