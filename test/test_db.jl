@testset "DB" begin
    mock_db = DB(
        Dict{Char, Dict{String, Lemma}}(),
        Dict{Char, Dict{Int, Synset}}(),
		Dict{Tuple{Int,String}, String}()
    )

    @testset "path_to_data_file" begin
        expected = joinpath("MockDB", "dict", "data.verb")
        @test WordNet.path_to_data_file("MockDB", 'v') == expected
    end

    @testset "path_to_index_file" begin
        expected = joinpath("MockDB", "dict", "index.verb")
        @test WordNet.path_to_index_file("MockDB", 'v') == expected
    end

    @testset "show" begin
        @test io_to_string(io -> show(io, mock_db)) == "WordNet.DB"
    end
end
