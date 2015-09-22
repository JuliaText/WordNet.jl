facts("DB") do
    const mock_db = DB(joinpath(dirname(@__FILE__), "mock_db"))

    context("path_to_data_file") do 
        expected = joinpath("MockDB", "dict", "data.verb")
        @fact WordNet.path_to_data_file("MockDB", 'v') --> expected
    end

    context("path_to_index_file") do 
        expected = joinpath("MockDB", "dict", "index.verb")
        @fact WordNet.path_to_index_file("MockDB", 'v') --> expected
    end

    context("show") do 
        @fact io_to_string(io -> show(io, mock_db)) --> "WordNet.DB"
    end

    context("getindex") do
        @fact mock_db['n', "'hood"].word --> "'hood"
        @fact mock_db["'hood", 'n'].word --> "'hood"
    end

    context("synsets") do 
        ss = synsets(mock_db, mock_db['n', "'hood"])

        @fact length(ss) --> 1
        @fact ss[1].gloss --> "(slang) a neighborhood"
    end

    context("expanded_hypernym") do
        ss = synsets(mock_db, mock_db['n', "'hood"])[1]
        @fact length(expanded_hypernym(mock_db, ss)) --> 8
    end

    context("antonym") do 
        ss = synsets(mock_db, mock_db['n', "'hood"])[1]
        @fact length(antonym(mock_db, ss)) --> 0
    end
end
