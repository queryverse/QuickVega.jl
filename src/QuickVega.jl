module QuickVega

using VegaLite

export histogram
export lineplot
export barplot

include("histogram.jl")
include("lineplot.jl")
include("barplot.jl")
end # module


