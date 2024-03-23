# Estrin.jl

[![Build Status](https://github.com/ArrogantGao/Estrin.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ArrogantGao/Estrin.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/ArrogantGao/Estrin.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/ArrogantGao/Estrin.jl)

Estrin.jl is an implementation of the [Estrin's scheme](https://en.wikipedia.org/wiki/Estrin's_scheme) for evaluating polynomials in Julia.

## Installation

Type `]` in the Julia REPL to use the package mode, then type the following command to install the package.
```julia
add Estrin
```

## Usage

```julia
julia> using Estrin

# generate a random polynomial
julia> C = rand(10);

julia> poly = Poly(C);

# evaluate the polynomial at x = 1
julia> s = poly(1.0)

julia> s ≈ sum(C)
true
```

## The Estrin's scheme

Given an arbitrary polynomial 
```math
P(x) = C_0 + C_1 x + C_2 x^2 + C_3 x^3 + ⋯ + C_n x^n
```
one can group adjacent terms into sub-expressions of the form $(A + Bx)$ and rewrite it as a polynomial in $x^2$: 
```math
P(x) = (C_0 + C_1x) + (C_2 + C_3 x) x^2 + ⋯ = Q(x^2).
```
These parameter can be calculated in parallel via SIMD, which can be more efficient than the traditional Horner's method.

However, it is obvious that the Estrin's scheme needed additional $N$ registers to store the intermediate results, which may be a bottleneck when the polynomial is large.
Thus, the tile-based Estrin's scheme is proposed to reduce the number of registers needed.
Instead of calculating the polynomial in one step, the tile-based Estrin's scheme divides the polynomial into multiple tiles (here I took the tiling size as $n = 16$), as
```math
P(x) = C'_0 + C'_1 x^{n} + C'_2 x^{2n} + C'_3 x^{3n} + ⋯ = Q(x^{n})
```
where $C'_i$ is the coefficient of the $i$-th tile calculated by the Estrin's scheme.
Then this process can be repeated recursively until the polynomial is small enough.

## Benchmarks

Benchmarks scripts and results are stored in the following repo: https://github.com/ArrogantGao/Polynomial_Benchmarks.
The results are shown below, where I compared the performance of Estrin's scheme (with and without tiling) with Horner's method and the Polynomial.jl package.

![](https://github.com/ArrogantGao/Polynomial_Benchmarks/raw/main/scripts/out/XZDesktop/2024-03-23--21-48-52/estrin_vs_horner_vs_polynomial_Float32.png)

![](https://github.com/ArrogantGao/Polynomial_Benchmarks/raw/main/scripts/out/XZDesktop/2024-03-23--21-48-52/estrin_vs_horner_vs_polynomial_Float64.png)