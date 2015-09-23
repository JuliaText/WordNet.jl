export Lemma

const SPACE = ' '

immutable Lemma
    word::AbstractString
    pos::Char
    tagsense_count::Int
    synset_offsets::Vector{Int}
    id::Int
    pointer_syms::Vector{AbstractString}
end

function Lemma(lexicon_line, id)
    parts = split(lexicon_line, SPACE)
    
    word = shift!(parts)
    pos = shift!(parts)[1]
    synset_count = parse(Int, shift!(parts))

    n_syms = parse(Int, shift!(parts))
    pointer_syms = [s for s in parts[1:n_syms]]
    parts = parts[n_syms+2:end]

    tagsense_count = parse(Int, shift!(parts))
    synset_offsets = [parse(Int, c) for c in parts[1:synset_count]]
    
    Lemma(word, pos, tagsense_count, synset_offsets, id, pointer_syms)
end

Base.show(io::IO, lemma::Lemma) = print(io, "$(lemma.word).$(lemma.pos)")
