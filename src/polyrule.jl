function horner_rule(x::T, poly::Poly{N, T}) where {N, T}
    coeffs = poly.coeffs
    result = coeffs[N]
    for i in N-1:-1:1
        result = muladd(result, x, coeffs[i])
    end
    return result
end

function naive_sum(x::T, poly::Poly{N, T}) where {N, T}
    coeffs = poly.coeffs
    result = zero(T)
    for i in 1:N
        result += coeffs[i] * x^(i-1)
    end
    return result
end

function estrin_rule(x::T, poly::Poly{N, T}) where {N, T}
    if N > 2
        poly_new = Poly{div(N + 1, 2), T}(ntuple(i -> muladd(x, poly[2 * i], poly[2*i - 1]), Val(div(N + 1, 2))))
        return estrin_rule(x^2, poly_new)
    else
        return muladd(x, poly[2], poly[1])
    end
end