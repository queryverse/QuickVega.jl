function lineplot(data; x_col=:x, y_col=:y, kwargs...) # assumes Tables.jl format
    p = @vlplot(data=data,mark=:line, x=x_col, y=y_col)
    updatePlot!(p;kwargs...)
    return p
end

function lineplot(data::AbstractVector; kwargs...)
    lineplot(DataFrame(x=collect(1:length(data)), y=data); kwargs...)
end

function lineplot(x::AbstractVector, y::AbstractVector; kwargs...)
    scatterplot(DataFrame(x=x, y=y); kwargs...)
end


function lineplot(data::AbstractArray{T, 2}; kwargs...) where {T}
    rows, cols = size(data)
    if rows == 1 #treat like a vector
        lineplot(vec(data); kwargs...)
    else
        lineplot(DataFrame(x=data[:, 1], y=data[:,2]); kwargs...)
    end
end
