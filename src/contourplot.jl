
function contourplot(x::AbstractVector, y::AbstractVector,z)

  # declare empty array to receive data to be plotted
  data = Array{Float64}(undef, 0, 4)

  # to differentiate when there is a lineb reak in the same contour
  group = 0

  # iterate the contours
  for cl in Contour.levels(Contour.contours(x,y,z))
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
  return @vlplot(data=df,
           mark="line",
           x      = {:x,type="quantitative"},
           y      = {:y,type="quantitative"},
           color  = {:z,type="quantitative"},
           order  = {field="row",type="quantitative"},
           detail = {:group,type="quantitative"})

  # There is a bug in VegaLite.jl, and the code below is note working
  # By now, the implementation requires the use of DataFrame
  #  return @vlplot(mark="line",
           #  x      = {data[:,1],type="quantitative"},
           #  y      = {data[:,2],type="quantitative"},
           #  color  = {data[:,3],type="quantitative"},
           #  order  = {field="row",type="quantitative"},
           #  detail = {data[:,4],type="quantitative"})

end

function contourplot(f, x::AbstractVector, y::AbstractVector)

  # calculate the z variable according to function f
  z = [f(xi,yi) for xi in x, yi in y];

  return contourplot(x,y,z)
end
