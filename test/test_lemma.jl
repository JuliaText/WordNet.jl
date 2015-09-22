facts("Lemma") do
    context("constructor") do 
        lemma = Lemma("fruit n 3 3 @ ~ + 3 3 13134947 04612722 07294550", 123)
        
        @fact lemma.id --> 123
        @fact lemma.word --> "fruit"
        @fact lemma.pos --> 'n'
        @fact lemma.pointer_syms --> ["@", "~", "+"]
        @fact lemma.tagsense_count --> 3
        @fact lemma.synset_offsets --> [13134947, 4612722, 7294550]
    end

    context("show") do 
        lemma = Lemma("fruit n 3 3 @ ~ + 3 3 13134947 04612722 07294550", 123)

        @fact io_to_string(io -> show(io, lemma)) --> "fruit.n"
    end
end