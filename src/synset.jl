export Synset, word_count, words, relation
export antonym, hypernym, hypernyms, expanded_hypernym

immutable Synset
    synset_offset::Int
    lex_filenum::Int
    word_counts::Dict{String, Int}
    synset_type::Char
    pos_offset::Int
    pos::Char
    pointers::Vector{Pointer}
    gloss::String
end

function Synset(line::String, pos::Char, offset)
    data_line = strip(line)
    
    dl_parts = split(data_line, " | ")
    info_line = dl_parts[1]
    gloss = dl_parts[2]
    line = split(info_line, SPACE)
    
    synset_offset = parse(Int, shift!(line))
    lex_filenum = parse(Int, shift!(line))
    synset_type = shift!(line)[1]

    n_words = parse(Int, shift!(line))
    word_counts = Dict{String, Int}()
    for _ in 1:n_words
        k = shift!(line)
        word_counts[k] = parse(Int, shift!(line))
    end

    n_pointers = parse(Int, shift!(line))
    pointers = [
        Pointer(
            string(shift!(line)[1]), 
            parse(UInt, shift!(line)), 
            shift!(line)[1], 
            shift!(line)
        )
        for _ in 1:n_pointers
    ]

    Synset(
        synset_offset,
        lex_filenum,
        word_counts,
        synset_type,
        offset,
        pos,
        pointers,
        gloss
    )
end


word_count(synset::Synset) = length(synset.word_counts)
words(synset::Synset) = keys(synset.word_counts)

relation(synset::Synset, pointer_sym) = map(
    ptr -> Synset(synset.synset_type, ptr.offset),
    filter(ptr -> ptr.sym == pointer_sym, synset.pointers)
)

antonym(synset::Synset)  = relation(synset, ANTONYM)
hypernym(synset::Synset) = relation(synset, HYPERNYM)[1]
hyponym(synset::Synset)  = relation(synset, HYPONYM)

function expanded_hypernym(synset::Synset)
    parent = hypernym(synset)
    hypernyms = Vector{Synset}()
    isempty(parent) && return hypernyms

    offsets = Vector{Int}()
    while !isempty(parent)
        parent.pos_offset ∈ offsets && break
        push!(hypernyms, Synset(synset.pos, offset))
        parent = parent.parent
    end

    hypernyms
end

function Base.show(synset::Synset)
    ws = join(map(word -> replace(word, "_", " "), words(synset)), ", ")
    "($(synset.synset_type)) $ws ($(synset.gloss))"
end
