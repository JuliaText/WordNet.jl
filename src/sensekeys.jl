export sensekey, sensekeys

function sensekey(db::DB, ss::Synset, lem::Lemma)
    db.sensekeys[(ss.offset, lem.word)]
end

function sensekeys(db::DB, lem::Lemma)
    [db.sensekeys[(ss_offset, lem.word)] for ss_offset in lem.synset_offsets]
end
