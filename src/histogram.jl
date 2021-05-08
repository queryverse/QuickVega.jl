function histogram(vector::AbstractVector; max_bins=10, kwargs...)

  p = @vlplot(data=data,
              mark={type=:bar},
              x={vector,type="quantitative", bin={maxbins=max_bins}},
              y="count()")

  updatePlot!(p;defaultParameters...)
  updatePlot!(p;kwargs...)
  return p

end

function histogram(data, col_name; max_bins=10, kwargs...)

  p =  @vlplot(data=data,
                mark={type=:bar},
                x={col_name,type="quantitative",bin={maxbins=max_bins}},
                y="count()")

  updatePlot!(p;defaultParameters...)
  updatePlot!(p;kwargs...)
  return p
end
