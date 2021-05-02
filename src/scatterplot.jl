function scatterplot(data, x_col=:x, y_col=:y;kwargs...) # assumes Tables.jl format
    p = @vlplot(data=data,:circle, x=x_col, y=y_col)
    updatePlot!(p;kwargs...)
    return p
end

function scatterplot(data::AbstractVector;kwargs...)
    scatterplot(DataFrame(x=collect(1:length(data)), y=data))
end

function scatterplot(x::AbstractVector, y::AbstractVector;kwargs...)
    scatterplot(DataFrame(x=x, y=y);kwargs...)
end


function scatterplot(data::AbstractArray{T, 2};kwargs...) where {T}
    rows, cols = size(data)
    if rows == 1 #treat like a vector
        scatterplot(vec(data);kwargs...)
    else
        scatterplot(DataFrame(x=data[:, 1], y=data[:,2]);kwargs...)
    end
end
