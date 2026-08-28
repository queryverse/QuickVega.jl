# QuickVega.jl

QuickVega provides a small data-first API for common plot types on top of VegaLite.jl.

## v1 API

- `qscatter(data; x, y, color=nothing, size=nothing, kwargs...)`
- `qline(data; x, y, color=nothing, kwargs...)`
- `qbar(data; x, y=nothing, color=nothing, kwargs...)`
- `qhist(data; x, bins=nothing, color=nothing, kwargs...)`

Each function returns a standard `VegaLite.VLSpec`, so you can continue customizing with VegaLite.jl.

## Example

```julia
using QuickVega

data = (x=[1, 2, 3], y=[2, 3, 5], grp=["a", "a", "b"])

p = qscatter(data; x=:x, y=:y, color=:grp, width=320, height=240)

# `p` is a VegaLite.VLSpec and can be further modified with VegaLite tools.
```
