"""
contourplot(x::AbstractVector, y::AbstractVector,
    z::AbstractArray{T,2},levels=nothing;mark="line", kwargs...)
This function returns a contour plot. The variable `levels` can
be either `Int` representing the number of levels or a list
of values representing the actual levels to be used. It's an
optional attribute, and in case the user leaves as `nothing`
a default value if provided by the `Contour.contours()` function.

Instead of the contour lines, the user may use `mark = "area"`
in order to get the filled contours.
"""
function contourplot(x::AbstractVector,
    y::AbstractVector,
    z::AbstractArray{T,2},
    levels=nothing; mark="line",
    kwargs...) where T

  # declare empty array to receive data to be plotted
  data = Array{Float64}(undef, 0, 4)

  # to differentiate when there is a lineb reak in the same contour
  group = 1

  if levels == nothing
    allcl =  Contour.levels(Contour.contours(x,y,z))
  else
    allcl = Contour.levels(Contour.contours(x,y,z,levels))
  end

  # iterate the contours
  # for cl in Contour.levels(Contour.contours(x,y,z))
  for cl in allcl
    lvl = Contour.level(cl)
    for line in Contour.lines(cl)
      # coordinates of this line segment
      xs, ys = Contour.coordinates(line) 
      data   = vcat(data,[xs ys ones(length(xs))*lvl ones(length(xs))*group])
      group += 1 
    end
  end

  # Partial implementation due to bug on VegaLite.jl
  df = DataFrames.DataFrame(data,["x","y","z","group"]);
  p  = @vlplot(data=df,
           mark   = {type=mark },
           x      = { field="x",type="quantitative" },
           y      = { field="y",type="quantitative" },
           color  = { field="z",type="quantitative" },
           order  = { field="row",type="quantitative" },
           detail = { field="group",type="quantitative" })
  updatePlot!(p;kwargs...)
  return p

end

function contourplot(f, x::AbstractVector, y::AbstractVector,
  levels=nothing; kwargs...)

  # calculate the z variable according to function f
  z = [f(xi,yi) for xi in x, yi in y];

  return contourplot(x,y,z,levels; kwargs...)
end


function contourplot(x::AbstractVector, y::AbstractVector,
  levels=nothing; kwargs...)
  # use kde to estimate a density to apply the contourplot
  d = KernelDensity.kde([x y])

  return contourplot(d.x,d.y,d.density,levels; kwargs...)
end

function contourplot(data::AbstractArray{T, 2},
  levels=nothing; kwargs...) where {T}

  # use kde to estimate a density to apply the contourplot
  d = KernelDensity.kde(data)

  return contourplot(d.x,d.y,d.density,levels; kwargs...)
end

  # There is a bug in VegaLite.jl, and the code below is note working
  # By now, the implementation requires the use of DataFrame
  #  return @vlplot(mark="line",
  #           x      = {data[:,1],type="quantitative"},
  #           y      = {data[:,2],type="quantitative"},
  #           color  = {data[:,3],type="quantitative"},
  #           order  = {field="row",type="quantitative"},
  #           detail = {data[:,4],type="quantitative"})
