"""
updatePlot!(p::VegaLite.VLSpec; kwargs...)
This function updates visualization `p` according to the parameters provided.
Note that the **order** to which the parameters are provided is important, since an
attribute must be first created in order for it to be updated. For example,
`zcolor` must be provided before `zcolor_type`.
"""
function updatePlot!(p::VegaLite.VLSpec;kwargs...)
  for (key,value) in kwargs
    # TODO: Write a proper way to handle the errors

    if key == :color
      p.params["encoding"]["color"] = OrderedDict{String,Any}("value"=>value) 
    end
    
    if key == :zcolor

        # TODO: Better way to infer the type of data
      if length(value)>1
        # TODO: Check if the length of the array is equal to the data inside the plot p
        p.params["data"]["values"].columns[:zcolor]= value
        p.params["encoding"]["color"] = OrderedDict{String,Any}("field"=>:zcolor,"type"=>"quantitative") 
      else
        p.params["encoding"]["color"] = OrderedDict{String,Any}("field"=>value,"type"=>"quantitative") 
      end
    end

    if key == :zcolor_type
      p.params["encoding"]["color"]["type"] = value
    end

    if key == :color_scheme
      p.params["encoding"]["color"]["scale"] = OrderedDict{String,Any}("scheme"=>value) 
    end

    if key == :x_agg
      p.params["encoding"]["x"]["aggregate"] = value
    end
    if key == :y_agg
      p.params["encoding"]["y"]["aggregate"] = value
    end
  end
end

function inferType(x,y)
  type_x = "quantitative"
  type_y = "quantitative"
  if typeof(x[1]) <: Int
    type_x = "ordinal"
  elseif typeof(x[1]) <: Union{Char,AbstractString}
    type_x = "nominal"
  end

  if typeof(y[1]) <: Int
    type_x = "ordinal"
  elseif typeof(y[1]) <: AbstractString
    type_x = "nominal"
  end
  return type_x, type_y
end