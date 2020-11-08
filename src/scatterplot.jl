using DataFrames


function scatterplot(data; x_col=:x, y_col=:y) # assumes Tables.jl format
    data |> @vlplot(:circle, x=x_col, y=y_col)
end

function scatterplot(data::AbstractVector)
    scatterplot(DataFrame(x=collect(1:length(data)), y=data))
end

function scatterplot(x::AbstractVector, y::AbstractVector)
    scatterplot(DataFrame(x=x, y=y))
end


function scatterplot(data::AbstractArray{T, 2}) where {T}
    rows, cols = size(data)
    if rows == 1 #treat like a vector
        scatterplot(vec(data))
    else
        scatterplot(DataFrame(x=data[:, 1], y=data[:,2]))
    end
end
