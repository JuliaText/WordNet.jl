export synsets, antonyms, hypernyms, hyponyms, expanded_hypernyms, expanded_hyponyms

synsets(db::DB, lemma::Lemma) = map(lemma.synset_offsets) do offset
    db.synsets[lemma.pos][offset]
end

relation(db::DB, synset::Synset, pointer_sym) = map(
    ptr -> db.synsets[ptr.pos][ptr.offset],
    filter(ptr -> ptr.sym == pointer_sym, synset.pointers)
)

function expanded_relation(db::DB, synset::Synset, pointer_sym)
    all_related = Set{Synset}()
    queue = relation(db, synset, pointer_sym)

    while !isempty(queue)
        node = pop!(queue)
        push!(all_related, node)
        local_relatives = setdiff(relation(db, node, pointer_sym), all_related)
        delete!(local_relatives, synset)
        union!(queue, local_relatives)
    end

    all_related
end

antonyms(db::DB, synset::Synset)  = relation(db, synset, ANTONYM)
hyponyms(db::DB, synset::Synset)  = relation(db, synset, HYPONYM)
hypernyms(db::DB, synset::Synset) = relation(db, synset, HYPERNYM)


expanded_hyponyms(db::DB, synset::Synset) = expanded_relation(db, synset, HYPONYM)
expanded_hypernyms(db::DB, synset::Synset) = expanded_relation(db, synset, HYPERNYM)
