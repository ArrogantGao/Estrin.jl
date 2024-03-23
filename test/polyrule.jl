@testset "naive, horner and Estrin" begin
    for T in [Float32, Float64, ComplexF32, ComplexF64]
        for N in [2^i for i in 0:6]
            poly = Poly(rand(T, N))
            for j in 1:100
                x = randn(T) * T(0.9)
                @test naive_sum(x, poly) ≈ horner_rule(x, poly) ≈ estrin_rule(x, poly) ≈ estrin_rule_tile(x, poly)
            end
        end
    end
end