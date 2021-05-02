module QuickVega

using VegaLite
using Contour
using KernelDensity
using DataStructures

export histogram
export lineplot
export barplot
export scatterplot
export contourplot

include("handleKwargs.jl")
include("histogram.jl")
include("contourplot.jl")
include("lineplot.jl")
include("barplot.jl")
include("scatterplot.jl")
end # module


