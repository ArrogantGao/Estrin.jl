using Estrin
using Test
using Random
Random.seed!(1234)

@testset "Estrin.jl" begin
    include("polyrule.jl")
    include("interface.jl")
end
