function scatterplot(data, x=:x, y=:y; kwargs...)
    x_type = inferType(data[!,x])
    y_type = inferType(data[!,y])
    p = @vlplot(data=data,
                mark={type=:circle},
                x={field=x,type=x_type},
                y={field=y,type=y_type})

    updatePlot!(p;defaultParameters...)
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
