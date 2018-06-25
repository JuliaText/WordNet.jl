facts("sensekeys") do
    mock_db = DB(joinpath(dirname(@__FILE__), "mock_db"))

    
    lem = mock_db["section", 'n']
    ss = synsets(mock_db, lem)
    @fact sensekeys(mock_db, lem) --> ["section%1:15:01::"]
    @fact sensekey(mock_db, ss[1], lem) --> "section%1:15:01::"
end
