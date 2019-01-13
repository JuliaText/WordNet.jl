@testset "operations" begin
    mock_db = DB(joinpath(@__DIR__, "mock_db"))

    @testset "getindex" begin
        @test mock_db['n', "'hood"].word == "'hood"
        @test mock_db["'hood", 'n'].word == "'hood"
    end

    @testset "synsets" begin
        ss = synsets(mock_db, mock_db['n', "'hood"])

        @test length(ss) == 1
        @test ss[1].gloss == "(slang) a neighborhood"
    end

    @testset "expanded_hypernyms" begin
        ss = synsets(mock_db, mock_db['n', "'hood"])[1]
        @test length(expanded_hypernyms(mock_db, ss)) == 8
    end

    @testset "antonyms" begin
        ss = synsets(mock_db, mock_db['n', "'hood"])[1]
        @test length(antonyms(mock_db, ss)) == 0
    end
end
