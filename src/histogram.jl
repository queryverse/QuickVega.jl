function histogram(vector::AbstractVector)
  return @vlplot(:bar, x={vector, bin=true}, y="count()")
end

function histogram(data, col_name; use_bin=true)
  return data |> @vlplot(:bar, x={col_name, bin=use_bin}, y="count()")

end