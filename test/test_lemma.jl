@testset "Lemma" begin
    @testset "constructor" begin
        lemma = Lemma("fruit n 3 3 @ ~ + 3 3 13134947 04612722 07294550", 123)

        @test lemma.id == 123
        @test lemma.word == "fruit"
        @test lemma.pos == 'n'
        @test lemma.pointer_syms == ["@", "~", "+"]
        @test lemma.tagsense_count == 3
        @test lemma.synset_offsets == [13134947, 4612722, 7294550]
    end

    @testset "show" begin
        lemma = Lemma("fruit n 3 3 @ ~ + 3 3 13134947 04612722 07294550", 123)

        @test io_to_string(io -> show(io, lemma)) == "fruit.n"
    end
end