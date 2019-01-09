@testset "sensekeys" begin
    mock_db = DB(joinpath(@__DIR__, "mock_db"))


    lem = mock_db["section", 'n']
    ss = synsets(mock_db, lem)
    @test sensekeys(mock_db, lem) == ["section%1:15:01::"]
    @test sensekey(mock_db, ss[1], lem) == "section%1:15:01::"
end
