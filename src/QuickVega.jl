module QuickVega

using VegaLite

export histogram
export lineplot
export barplot
export scatterplot

include("histogram.jl")
include("lineplot.jl")
include("barplot.jl")
include("scatterplot.jl")
end # module


