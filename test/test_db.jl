facts("path_to_dict") do
    context("returns correct path") do 
        expected = joinpath("MockDB", "dict", "data.verb")
        @fact WordNet.path_to_dict(DB("MockDB"), 'v') --> expected
    end
end
