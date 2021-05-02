function updatePlot!(p::VegaLite.VLSpec;kwargs...)
  for (key,value) in kwargs

    if key == :color
      p.params["encoding"]["color"] = OrderedDict{String,Any}("value"=>value) 
    end

    if key == :color_scheme
      p.params["encoding"]["color"]["scale"] = OrderedDict{String,Any}("scheme"=>value) 
    end
  end

end