using DataFrames


function lineplot(data; x_col=:x, y_col=:y) # assumes Tables.jl format
    data |> @vlplot(:line, x=x_col, y=y_col)
end

function lineplot(data::AbstractVector)
    lineplot(DataFrame(x=collect(1:length(data)), y=data))
end

function lineplot(x::AbstractVector, y::AbstractVector)
    scatterplot(DataFrame(x=x, y=y))
end


function lineplot(data::AbstractArray{T, 2}) where {T}
    rows, cols = size(data)
    if rows == 1 #treat like a vector
        lineplot(vec(data))
    else
        lineplot(DataFrame(x=data[:, 1], y=data[:,2]))
    end
end
