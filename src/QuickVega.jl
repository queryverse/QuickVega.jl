module QuickVega

using VegaLite
using Contour
using KernelDensity
using DataStructures
using DataFrames

export histogram
export lineplot
export barplot
export scatterplot
export contourplot
export updatePlot!

include("updateSpecs.jl")
include("histogram.jl")
include("contourplot.jl")
include("lineplot.jl")
include("barplot.jl")
include("scatterplot.jl")
end # module


