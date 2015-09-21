facts("DB") do
    context("path_to_data_file") do 
        expected = joinpath("MockDB", "dict", "data.verb")
        @fact WordNet.path_to_data_file(DB("MockDB"), 'v') --> expected
    end

    context("path_to_index_file") do 
        expected = joinpath("MockDB", "dict", "index.verb")
        @fact WordNet.path_to_index_file(DB("MockDB"), 'v') --> expected
    end
end
