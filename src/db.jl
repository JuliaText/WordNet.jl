export DB

struct DB
    lemmas::Dict{Char, Dict{String, Lemma}}
    synsets::Dict{Char, Dict{Int, Synset}}
    sensekeys::Dict{Tuple{Int, String}, String}
end

function DB(base_dir::AbstractString=datadep"WordNet 3.0")
    DB(
        load_lemmas(base_dir),
        load_synsets(base_dir),
        load_sensekeys(base_dir)
    )
end

Base.show(io::IO, db::DB) = print(io, "WordNet.DB")

function Base.getindex(db::DB, pos::Char, word::AbstractString)
    db.lemmas[pos][lowercase(word)]
end

Base.getindex(db::DB, word::AbstractString, pos::Char) = db[pos, word]

function load_lemmas(base_dir)
    lemmas = Dict{Char, Dict{String, Lemma}}()

    for pos in ['n', 'v', 'a', 'r']
        d = Dict{String, Lemma}()

        open(path_to_index_file(base_dir, pos)) do f
            for (i, line) in enumerate(eachline(f))
                i > 29 || continue  # Skip Copyright.
                word = line[1:(findfirst(isequal(' '), line) - 1)]
                d[word] = Lemma(line, i-29)
            end
        end

        lemmas[pos] = d
    end

    lemmas
end

function load_synsets(base_dir)
    synsets = Dict{Char, Dict{Int, Synset}}()

    for pos in ('n', 'v', 'a', 'r')
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


function load_sensekeys(basedir)
    path=joinpath(basedir, "dict", "index.sense")
    sensekeys = Dict{Tuple{Int64, String}, String}()

    for line in eachline(path)
        full_key, offset_str, sense_num_str, tagcount_str = split(line)
        lemma_name = first(split(full_key, '%'))
        sense_offset = parse(Int64, offset_str)
        index = (sense_offset, lemma_name)
        @assert(!haskey(sensekeys, index))
        sensekeys[index] = full_key
    end

    sensekeys
end


function path_to_data_file(base_dir, pos)
    joinpath(base_dir, "dict", "data.$(SYNSET_TYPES[pos])")
end

function path_to_index_file(base_dir, pos)
    joinpath(base_dir, "dict", "index.$(SYNSET_TYPES[pos])")
end

Base.haskey(db::DB, pos::Char) = haskey(db.lemmas, pos)
Base.haskey(db::DB, pos::Char, word::AbstractString) = haskey(db, pos) ? haskey(db.lemmas[pos], word) : false

Base.get(db::DB, pos::Char, word::AbstractString, default) = haskey(db, pos, word) ? db.lemmas[pos][word] : default
Base.get(db::DB, word::AbstractString, pos::Char, default) = get(db, pos, word, default)
