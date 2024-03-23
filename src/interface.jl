function (poly::Poly{N, T})(x::T) where{N, T}
    return estrin_rule_tile(x, poly)
end