export Synset, word_count, words

struct Synset
    offset::Int
    lex_filenum::Int
    word_counts::Dict{String, Int}
    synset_type::Char
    pos::Char
    pointers::Vector{Pointer}
    gloss::String
end

const ∅ = Synset(
    -1,
    -1,
    Dict{String, Int}(),
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

    offset = parse(Int, popfirst!(line))
    lex_filenum = parse(Int, popfirst!(line))
    synset_type = popfirst!(line)[1]

    n_words = parse_int_hex(popfirst!(line))  # hex!
    word_counts = Dict{String, Int}()
    for _ in 1:n_words
        k = popfirst!(line)
        word_counts[k] = parse_int_hex(popfirst!(line))
    end

    n_pointers = parse(Int, popfirst!(line))
    pointers = [
        Pointer(
            string(popfirst!(line)[1]),
            parse(UInt, popfirst!(line)),
            popfirst!(line)[1],
            popfirst!(line)
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
    ws = join([replace(word, "_" => " ") for word in words(synset)], ", ")
    print(io, "($(synset.synset_type)) $ws ($(synset.gloss))")
end
