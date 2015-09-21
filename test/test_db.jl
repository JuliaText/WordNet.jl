facts("path_to_data_file") do
    context("returns correct path") do 
        expected = joinpath("MockDB", "dict", "data.verb")
        @fact WordNet.path_to_data_file(DB("MockDB"), 'v') --> expected
    end
end
