export synsets, antonyms, hypernyms, hyponyms, expanded_hypernyms, expanded_hyponyms

synsets(db::DB, lemma::Lemma) = map(lemma.synset_offsets) do offset
    db.synsets[lemma.pos][offset]
end

relation(db::DB, synset::Synset, pointer_sym) = map(
    ptr -> db.synsets[ptr.pos][ptr.offset],
    filter(ptr -> ptr.sym == pointer_sym, synset.pointers)
)

function expanded_relation(db::DB, synset::Synset, pointer_sym)
     # Inititally include self, so as to avoid cycles,
     # but we will delete it at the end
    all_related = Set{Synset}([synset])
    queue = relation(db, synset, pointer_sym)

    while !isempty(queue)
        node = pop!(queue)
        node in all_related && continue  # done this one already
        push!(all_related, node)

        union!(queue, relation(db, node, pointer_sym))
    end

    delete!(all_related, synset)
    return all_related
end

antonyms(db::DB, synset::Synset)  = relation(db, synset, ANTONYM)
hyponyms(db::DB, synset::Synset)  = relation(db, synset, HYPONYM)
hypernyms(db::DB, synset::Synset) = relation(db, synset, HYPERNYM)


expanded_hyponyms(db::DB, synset::Synset) = expanded_relation(db, synset, HYPONYM)
expanded_hypernyms(db::DB, synset::Synset) = expanded_relation(db, synset, HYPERNYM)
