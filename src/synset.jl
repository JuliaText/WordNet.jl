export Synset, word_count, words

immutable Synset
    offset::Int
    lex_filenum::Int
    word_counts::Dict{AbstractString, Int}
    synset_type::Char
    pos::Char
    pointers::Vector{Pointer}
    gloss::AbstractString
end

const ∅ = @compat Synset(
    -1, 
    -1, 
    Dict{AbstractString, Int}(),
    '-',
    '-',
    Vector{Pointer}(),
    ""
)

is_nothing(synset::Synset) = synset.offset == -1

parse_int_hex(s) = parse(Int, string("0x", s))

function Synset(raw_line::AbstractString, pos::Char)
    dl_parts = split(strip(raw_line), " | ")
    line = split(dl_parts[1], SPACE)
    gloss = join(dl_parts[2:end], " | ")
    
    offset = parse(Int, shift!(line))
    lex_filenum = parse(Int, shift!(line))
    synset_type = shift!(line)[1]

    n_words = parse_int_hex(shift!(line))  # hex!
    word_counts = Dict{AbstractString, Int}()
    for _ in 1:n_words
        k = shift!(line)
        word_counts[k] = parse_int_hex(shift!(line))
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
        offset,
        lex_filenum,
        word_counts,
        synset_type,
        pos,
        pointers,
        gloss
    )
end


word_count(synset::Synset) = length(synset.word_counts)
words(synset::Synset) = keys(synset.word_counts)

function Base.show(io::IO, synset::Synset)
    ws = join(map(word -> replace(word, "_", " "), words(synset)), ", ")
    print(io, "($(synset.synset_type)) $ws ($(synset.gloss))")
end
