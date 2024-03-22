@testset "poly interface" begin
    for T in [Float32, Float64, ComplexF32, ComplexF64]
        for N in [2^i for i in 0:5]
            poly = Poly(rand(T, N))
            for j in 1:100
                x = randn(T)
                @test naive_sum(x, poly) ≈ poly(x)
            end
        end
    end
end