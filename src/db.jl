export DB

immutable DB
    lemmas::Dict{Char, Dict{String, Lemma}}
end

function DB(base_dir::String)
    DB(load_lemmas(base_dir))
end

Base.show(io::IO, db::DB) = print(io, "Wordnet.DB")

function load_lemmas(base_dir)
    lemmas = Dict{Char, Dict{String, Lemma}}()

    for pos in ['n', 'v', 'a', 'r']
        d = Dict{String, Lemma}()
        
        open(WordNet.path_to_index_file(base_dir, pos)) do f
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
    Synset(db, lemma.pos, offset)
end
