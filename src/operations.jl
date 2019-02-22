export synsets, antonyms, hypernyms, hyponyms, expanded_hypernyms

synsets(db::DB, lemma::Lemma) = map(lemma.synset_offsets) do offset
    db.synsets[lemma.pos][offset]
end

relation(db::DB, synset::Synset, pointer_sym) = map(
    ptr -> db.synsets[ptr.pos][ptr.offset],
    filter(ptr -> ptr.sym == pointer_sym, synset.pointers)
)

antonyms(db::DB, synset::Synset)  = relation(db, synset, ANTONYM)
hyponyms(db::DB, synset::Synset)  = relation(db, synset, HYPONYM)

function hypernyms(db::DB, synset::Synset)
    Set(db.synsets[synset.synset_type][ptr.offset] for ptr ∈ synset.pointers if ptr.sym == HYPERNYM)
end

function expanded_hypernyms(db::DB, synset::Synset)
    path = Vector{Synset}()

    node = hypernyms(db, synset)
    while !is_nothing(node)
        push!(path, node)
        node = hypernyms(db, node)
    end

    path
end
