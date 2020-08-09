function histogram(vector::AbstractVector; use_bin=true)
  return @vlplot(:bar, x={vector, bin=use_bin}, y="count()")
end

function histogram(data, col_name; use_bin=true)
  return data |> @vlplot(:bar, x={col_name, bin=use_bin}, y="count()")

end