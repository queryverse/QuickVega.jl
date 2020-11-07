using DataFrames


function barplot(data; x_col=:x, y_col=:y) # assumes Tables.jl format
    data |> @vlplot(:bar, x=x_col, y=y_col)
end

function barplot(data::AbstractVector)
    lineplot(DataFrame(x=collect(1:length(data)), y=data))
end


function barplot(data::AbstractArray{T, 2}) where {T}
    rows, cols = size(data)
    if rows == 1 #treat like a vector
        barplot(vec(data))
    else
        barplot(DataFrame(x=data[:, 1], y=data[:,2]))
    end
end
