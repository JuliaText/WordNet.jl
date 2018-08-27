export sensecount, sensecounts

function sensecount(db::DB, ss::Synset, lem::Lemma)
    get(db.counts, sensekey(db, ss, lem), 0)
    # zero is default for senses that are not found in CNTLIST
    # note: this will still error for senses that doen't have a sense key
    # that is a good thing.
end

function sensecounts(db::DB, lem::Lemma)
    Dict([ss=>sensecount(db,  ss, lem) for ss in synsets(db, lem)])
end
