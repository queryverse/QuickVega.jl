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
export setTheme!

include("updateSpecs.jl")
include("histogram.jl")
include("contourplot.jl")
include("lineplot.jl")
include("barplot.jl")
include("scatterplot.jl")


defaultTheme = :light

lightTheme = Dict(
  :height=> 300,
  :width => 300
)

darkTheme = Dict(
  :height=> 300,
  :width => 300,
  :title_color => "white",
  :label_color => "white",
  :axis_color => "white",
  :guide_label_color => "white",
  :guide_title_color => "white",
  :background_color => "#333",
)

themesParameters = Dict(
  :light => lightTheme,
  :dark  => darkTheme
)

defaultParameters = themesParameters[defaultTheme]

function setTheme!(theme=:light)
  global defaultParameters = themesParameters[theme]
end

end # module


