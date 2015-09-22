export DB

immutable DB
    lemmas::Dict{Char, Dict{String, Lemma}}
    synsets::Dict{Char, Dict{Int, Synset}}
end

function DB(base_dir::String)
    DB(load_lemmas(base_dir), load_synsets(base_dir))
end

Base.show(io::IO, db::DB) = print(io, "Wordnet.DB")

function Base.getindex(db::DB, pos::Char, word::String) 
    db.lemmas[pos][lowercase(word)]
end

Base.getindex(db::DB, word::String, pos::Char) = db[pos, word]

function load_lemmas(base_dir)
    lemmas = Dict{Char, Dict{String, Lemma}}()

    for pos in ['n', 'v', 'a', 'r']
        d = Dict{String, Lemma}()
        
        open(path_to_index_file(base_dir, pos)) do f
            for (i, line) in enumerate(eachline(f))
                i > 29 || continue  # Skip Copyright.
                word = line[1:(search(line, ' ')-1)]
                d[word] = Lemma(line, i-29)
            end
        end
        
        lemmas[pos] = d
    end

    lemmas
end

function load_synsets(base_dir)
    synsets = Dict{Char, Dict{Int, Synset}}()
    
    for pos in ['n', 'v', 'a', 'r']
        d = Dict{Int, Synset}()

        open(path_to_data_file(base_dir, pos)) do f
            for (i, line) in enumerate(eachline(f))
                i > 29 || continue # Skip Copyright.
                ss = Synset(line, pos)
                d[ss.offset] = ss  # ≡ to position(f)
            end
        end

        synsets[pos] = d
    end
    
    synsets
end

function path_to_data_file(base_dir, pos)
    joinpath(base_dir, "dict", "data.$(SYNSET_TYPES[pos])")
end

function path_to_index_file(base_dir, pos)
    joinpath(base_dir, "dict", "index.$(SYNSET_TYPES[pos])")
end

SYNSET_TYPES = @compat Dict{Char, String}(
    'n' => "noun", 'v' => "verb", 'a' => "adj", 'r' => "adv"
)

synsets(db::DB, lemma::Lemma) = map(lemma.synset_offsets) do offset
    db.synsets[lemma.pos][offset]
end

antonym(db::DB, synset::Synset)  = relation(db, synset, ANTONYM)
hypernym(db::DB, synset::Synset) = get(relation(db, synset, HYPERNYM), 1, ROOT)
hyponym(db::DB, synset::Synset)  = relation(db, synset, HYPONYM)

relation(db::DB, synset::Synset, pointer_sym) = map(
    ptr -> db.synsets[synset.synset_type][ptr.offset],
    filter(ptr -> ptr.sym == pointer_sym, synset.pointers)
)

function expanded_hypernym(db::DB, synset::Synset)
    hypernyms = Vector{Synset}()
    
    node = hypernym(db, synset)
    while !is_root(node)
        push!(hypernyms, node)
        node = hypernym(db, node)
    end
    
    hypernyms
end
