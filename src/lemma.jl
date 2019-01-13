export Lemma

const SPACE = ' '

struct Lemma
    word::String
    pos::Char
    tagsense_count::Int
    synset_offsets::Vector{Int}
    id::Int
    pointer_syms::Vector{String}
end

function Lemma(lexicon_line, id)
    parts = split(lexicon_line, SPACE)

    word = popfirst!(parts)
    pos = popfirst!(parts)[1]
    synset_count = parse(Int, popfirst!(parts))

    n_syms = parse(Int, popfirst!(parts))
    pointer_syms = [s for s in parts[1:n_syms]]
    parts = parts[n_syms+2:end]

    tagsense_count = parse(Int, popfirst!(parts))
    synset_offsets = [parse(Int, c) for c in parts[1:synset_count]]

    Lemma(word, pos, tagsense_count, synset_offsets, id, pointer_syms)
end

Base.show(io::IO, lemma::Lemma) = print(io, "$(lemma.word).$(lemma.pos)")
