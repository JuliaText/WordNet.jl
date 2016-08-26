facts("DB") do
    const mock_db = DB(
        Dict{Char, Dict{AbstractString, Lemma}}(),
        Dict{Char, Dict{Int, Synset}}(),
		Dict{Tuple{Int,AbstractString}, AbstractString}()
    )

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
end
