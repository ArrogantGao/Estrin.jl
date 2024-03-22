module Estrin

using LoopVectorization

export Poly
export naive_sum, horner_rule, estrin_rule

include("types.jl")
include("polyrule.jl")
include("interface.jl")

end
