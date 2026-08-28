# QuickVega.jl Design Document

## Goal

Create a new package, `QuickVega.jl`, that provides a small library of one-function shortcuts for common statistical plots.

The design goal is similar in spirit to Python's seaborn:

- very fast creation of common plots
- sensible defaults
- data-first API
- no requirement to learn a full grammar-of-graphics API for basic tasks

Unlike seaborn, `QuickVega.jl` should not introduce a separate rendering system. Instead, it should generate ordinary **Vega-Lite** specs via `VegaLite.jl`.

Users should then be able to further customize the returned plot with standard `VegaLite.jl` tools, especially the planned `@vlmod` macro.

Example target workflow:

```julia
p = qscatter(df; x=:height, y=:weight, color=:species)

p |> @vlmod(
    mark.opacity = 0.4,
    x.title = "Height (cm)",
    y.title = "Weight (kg)",
)