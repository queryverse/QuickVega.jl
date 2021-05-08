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

    # create the config
    if !("config" in p.params.keys)
      p.params["config"]  = OrderedDict{String,Any}(
        "axis"=>OrderedDict{String,Any}(),
        "style"=>OrderedDict{String,Any}(),
        "title"=>OrderedDict{String,Any}()
        )
    end

    if key == :title_color
      p.params["config"]["title"]["color"] = value
    end

    if key == :domain_color
      p.params["config"]["axis"]["domainColor"] = value
    end

    if key == :grid_color
      p.params["config"]["axis"]["gridColor"] = value
    end

    if key == :tick_color
      p.params["config"]["axis"]["tickColor"] = value
    end

    if key == :guide_label_color
      p.params["config"]["style"]["guide-label"] = OrderedDict{String,Any}("fill"=>value)
    end

    if key == :guide_title_color
      p.params["config"]["style"]["guide-title"] = OrderedDict{String,Any}("fill"=>value)
    end

    if key == :background_color
      p.params["background"] = value
    end

    if key == :title
      p.params["title"] = value
    end

    if key == :width
      p.params["width"] = value
    end

    if key == :height
      p.params["height"] = value
    end

    if key == :opacity
      p.params["mark"]["opacity"] = value
    end

    if key == :color
      p.params["encoding"]["color"] = OrderedDict{String,Any}("value"=>value) 
    end
    
    if key == :zcolor

      if typeof(value) <: Vector
        # TODO: Check if the length of the array is equal to the data inside the plot p
        color_type = inferType(value[1])
        p.params["data"]["values"].columns[:zcolor]= value
        p.params["encoding"]["color"] = OrderedDict{String,Any}("field"=>:zcolor,"type"=>color_type) 
      else
        color_type = inferType(p.params["data"]["values"].columns[value][1])
        p.params["encoding"]["color"] = OrderedDict{String,Any}("field"=>value,"type"=>color_type) 
      end
    end

    if key == :zcolor_type
      p.params["encoding"]["color"]["type"] = value
    end

    if key == :color_scheme
      p.params["encoding"]["color"]["scale"] = OrderedDict{String,Any}("scheme"=>value) 
    end

    if key == :zsize

      if typeof(value) <: Vector
        # TODO: Check if the length of the array is equal to the data inside the plot p
        size_type = inferType(value[1])
        p.params["data"]["values"].columns[:zsize]= value
        p.params["encoding"]["size"] = OrderedDict{String,Any}("field"=>:zsize,"type"=>size_type) 
      else
        size_type = inferType(p.params["data"]["values"].columns[value][1])
        p.params["encoding"]["size"] = OrderedDict{String,Any}("field"=>value,"type"=>size_type) 
      end
    end

    if key == :zsize_type
      p.params["encoding"]["size"]["type"] = value
    end

    if key == :x_agg
      p.params["encoding"]["x"]["aggregate"] = value
    end
    if key == :y_agg
      p.params["encoding"]["y"]["aggregate"] = value
    end
    if key == :color_agg
      p.params["encoding"]["color"]["aggregate"] = value
    end
    if key == :size_agg
      p.params["encoding"]["size"]["aggregate"] = value
    end
  end
end

function inferType(x)
  type_x = "quantitative"
  if typeof(x[1]) <: Int
    type_x = "ordinal"
  elseif typeof(x[1]) <: Union{Char,AbstractString}
    type_x = "nominal"
  end
  return type_x
end