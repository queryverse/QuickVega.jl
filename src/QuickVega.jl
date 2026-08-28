module QuickVega

using VegaLite

export qscatter, qline, qbar, qhist

const _CHANNEL_TYPE = Dict(
    :quantitative => "quantitative",
    :nominal => "nominal",
    :ordinal => "ordinal",
    :temporal => "temporal",
)

fieldname(field::Union{Symbol,AbstractString}) = string(field)

function _typed_channel(field::Union{Symbol,AbstractString}, typ::Symbol)
    haskey(_CHANNEL_TYPE, typ) || throw(ArgumentError("Unsupported channel type `$(typ)`."))
    return VegaLite.vlfrag(field=fieldname(field), type=_CHANNEL_TYPE[typ])
end

function _add_channel!(enc::Dict{String,Any}, channel::String, field::Union{Nothing,Symbol,AbstractString}, typ::Symbol)
    field === nothing && return enc
    enc[channel] = _typed_channel(field, typ)
    return enc
end

"""
    qscatter(data; x, y, color=nothing, size=nothing, x_type=:quantitative, y_type=:quantitative, color_type=:nominal, size_type=:quantitative, kwargs...)

Create a scatter plot and return a standard `VegaLite.VLSpec`.
"""
function qscatter(
    data;
    x,
    y,
    color=nothing,
    size=nothing,
    x_type::Symbol=:quantitative,
    y_type::Symbol=:quantitative,
    color_type::Symbol=:nominal,
    size_type::Symbol=:quantitative,
    kwargs...,
)
    enc = Dict{String,Any}(
        "x" => _typed_channel(x, x_type),
        "y" => _typed_channel(y, y_type),
    )
    _add_channel!(enc, "color", color, color_type)
    _add_channel!(enc, "size", size, size_type)

    return VegaLite.vlplot(:point, data=data, encoding=enc; kwargs...)
end

"""
    qline(data; x, y, color=nothing, x_type=:quantitative, y_type=:quantitative, color_type=:nominal, kwargs...)

Create a line plot and return a standard `VegaLite.VLSpec`.
"""
function qline(
    data;
    x,
    y,
    color=nothing,
    x_type::Symbol=:quantitative,
    y_type::Symbol=:quantitative,
    color_type::Symbol=:nominal,
    kwargs...,
)
    enc = Dict{String,Any}(
        "x" => _typed_channel(x, x_type),
        "y" => _typed_channel(y, y_type),
    )
    _add_channel!(enc, "color", color, color_type)

    return VegaLite.vlplot(:line, data=data, encoding=enc; kwargs...)
end

"""
    qbar(data; x, y=nothing, color=nothing, x_type=:nominal, y_type=:quantitative, color_type=:nominal, kwargs...)

Create a bar plot and return a standard `VegaLite.VLSpec`.

If `y` is not provided, the plot shows counts per `x` category.
"""
function qbar(
    data;
    x,
    y=nothing,
    color=nothing,
    x_type::Symbol=:nominal,
    y_type::Symbol=:quantitative,
    color_type::Symbol=:nominal,
    kwargs...,
)
    enc = Dict{String,Any}(
        "x" => _typed_channel(x, x_type),
    )

    if y === nothing
        enc["y"] = VegaLite.vlfrag(aggregate="count", type="quantitative")
    else
        enc["y"] = _typed_channel(y, y_type)
    end

    _add_channel!(enc, "color", color, color_type)

    return VegaLite.vlplot(:bar, data=data, encoding=enc; kwargs...)
end

"""
    qhist(data; x, bins=nothing, color=nothing, x_type=:quantitative, color_type=:nominal, kwargs...)

Create a histogram and return a standard `VegaLite.VLSpec`.

`bins` can be `nothing` (default Vega-Lite binning) or an `Int` for `maxbins`.
"""
function qhist(
    data;
    x,
    bins=nothing,
    color=nothing,
    x_type::Symbol=:quantitative,
    color_type::Symbol=:nominal,
    kwargs...,
)
    x_channel = _typed_channel(x, x_type)
    if bins === nothing
        x_channel.named["bin"] = true
    elseif bins isa Integer
        x_channel.named["bin"] = VegaLite.vlfrag(maxbins=Int(bins))
    else
        throw(ArgumentError("`bins` must be `nothing` or an integer."))
    end

    enc = Dict{String,Any}(
        "x" => x_channel,
        "y" => VegaLite.vlfrag(aggregate="count", type="quantitative"),
    )
    _add_channel!(enc, "color", color, color_type)

    return VegaLite.vlplot(:bar, data=data, encoding=enc; kwargs...)
end

end
