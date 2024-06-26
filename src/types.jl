struct Poly{N, T}
    coeffs::NTuple{N, T} # (C_0, C_1, ..., C_{N-1})
end

Poly(coeffs::AbstractVector{T}) where T = Poly{length(coeffs), T}(ntuple(i -> coeffs[i], length(coeffs)))

Base.getindex(poly::Poly{N, T}, i::Int) where {N, T} = i > N ? zero(T) : poly.coeffs[i]

Poly(poly::Poly{N1, T}, s::Int, ::Type{Poly{N2, T}}) where {N1, N2, T} = Poly{N2, T}(ntuple(i -> poly[s + i - 1], Val(N2)))