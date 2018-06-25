facts("operations") do
    mock_db = DB(joinpath(dirname(@__FILE__), "mock_db"))

    context("getindex") do
        @fact mock_db['n', "'hood"].word --> "'hood"
        @fact mock_db["'hood", 'n'].word --> "'hood"
    end

    context("synsets") do 
        ss = synsets(mock_db, mock_db['n', "'hood"])

        @fact length(ss) --> 1
        @fact ss[1].gloss --> "(slang) a neighborhood"
    end

    context("expanded_hypernyms") do
        ss = synsets(mock_db, mock_db['n', "'hood"])[1]
        @fact length(expanded_hypernyms(mock_db, ss)) --> 8
    end

    context("antonyms") do 
        ss = synsets(mock_db, mock_db['n', "'hood"])[1]
        @fact length(antonyms(mock_db, ss)) --> 0
    end
end
