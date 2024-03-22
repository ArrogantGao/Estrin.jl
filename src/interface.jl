function (poly::Poly{N, T})(x::T) where{N, T}
    return estrin_rule(x, poly)
end