function lineplot(data, x=:x, y=:y; kwargs...) # assumes Tables.jl format
    x_type = inferType(data[!,x])
    y_type = inferType(data[!,y])
    p = @vlplot(data=data,
                mark={type=:line},
                x={x,type=x_type},
                y={y,type=y_type})
    updatePlot!(p;defaultParameters...)
    updatePlot!(p;kwargs...)
    return p
end

function lineplot(data::AbstractVector; kwargs...)
    lineplot(DataFrame(x=collect(1:length(data)), y=data); kwargs...)
end

function lineplot(x::AbstractVector, y::AbstractVector; kwargs...)
    lineplot(DataFrame(x=x, y=y); kwargs...)
end


function lineplot(data::AbstractArray{T, 2}; kwargs...) where {T}
    rows, cols = size(data)
    if rows == 1 #treat like a vector
        lineplot(vec(data); kwargs...)
    else
        lineplot(DataFrame(x=data[:, 1], y=data[:,2]); kwargs...)
    end
end
