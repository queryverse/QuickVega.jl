function histogram(vector::AbstractVector; use_bin=true, kwargs...)

  p = @vlplot(data=data,:bar,
              x={vector,type="quantitative", bin=use_bin},
              y="count()")
  updatePlot!(p;kwargs...)
  return p

end

function histogram(data, col_name; use_bin=true, kwargs...)

  p =  @vlplot(data=data,:bar,
                x={col_name,type="quantitative",bin=use_bin},
                y="count()")
  updatePlot!(p;kwargs...)
  return p
end
