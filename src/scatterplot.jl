function scatterplot(data, x_col=:x, y_col=:y; kwargs...) # assumes Tables.jl format
    type_x, type_y = inferType(data[!,:x],data[!,:y])
    p = @vlplot(data=data,
                :circle,
                x={field=x_col,type=type_x},
                y={field=y_col,type=type_y})
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
