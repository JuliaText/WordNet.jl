export DB

immutable DB
    path::String
end

function path_to_dict(db::DB, pos)
    joinpath(db.path, "dict", "data.$(SYNSET_TYPES[pos])")
end

SYNSET_TYPES = Dict{Char, String}(
    'n' => "noun", 'v' => "verb", 'a' => "adj", 'r' => "adv"
)
