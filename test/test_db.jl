facts("DB") do
    context("path_to_data_file") do 
        expected = joinpath("MockDB", "dict", "data.verb")
        @fact WordNet.path_to_data_file("MockDB", 'v') --> expected
    end

    context("path_to_index_file") do 
        expected = joinpath("MockDB", "dict", "index.verb")
        @fact WordNet.path_to_index_file("MockDB", 'v') --> expected
    end
end
