module QuickVega

using VegaLite
using Contour
using KernelDensity

export histogram
export lineplot
export barplot
export scatterplot
export contourplot

include("histogram.jl")
include("contourplot.jl")
include("lineplot.jl")
include("barplot.jl")
include("scatterplot.jl")
end # module


