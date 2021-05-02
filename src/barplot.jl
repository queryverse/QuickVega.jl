using DataFrames


function barplot(data; x_col=:x, y_col=:y, kwargs...) # assumes Tables.jl format
    x_type, y_type = inferType(data[!,:x],data[!,:y])
    p = @vlplot(data=data,
                mark={type=:bar},
                x={x_col, type=x_type},
                y={y_col, type=y_type})
    updatePlot!(p;kwargs...)
    return p
end

function barplot(data::AbstractVector; kwargs...)
    barplot(DataFrame(x=collect(1:length(data)), y=data); kwargs...)
end

function barplot(x::AbstractVector, y::AbstractVector; kwargs...)
    barplot(DataFrame(x=x, y=y); kwargs...)
end


function barplot(data::AbstractArray{T, 2}; kwargs...) where {T}
    rows, cols = size(data)
    if rows == 1 #treat like a vector
        barplot(vec(data))
    else
        barplot(DataFrame(x=data[:, 1], y=data[:,2]); kwargs...)
    end
end
