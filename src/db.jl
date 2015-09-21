export DB

immutable DB
    path::String
end

function path_to_data_file(db::DB, pos)
    joinpath(db.path, "dict", "data.$(SYNSET_TYPES[pos])")
end

function path_to_index_file(db::DB, pos)
    joinpath(db.path, "dict", "index.$(SYNSET_TYPES[pos])")
end

SYNSET_TYPES = @compat Dict{Char, String}(
    'n' => "noun", 'v' => "verb", 'a' => "adj", 'r' => "adv"
)
