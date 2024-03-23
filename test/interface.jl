@testset "poly interface" begin
    for T in [Float32, Float64, ComplexF32, ComplexF64]
        for N in [2^i for i in 0:5]
            poly = Poly(randn(T, N))
            for x in T.([-1.0:0.01:1.0...])
                @test naive_sum(x, poly) ≈ poly(x)
            end
        end
    end
end