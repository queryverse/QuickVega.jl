using Revise, Pkg
using QuickVega, DataFrames, VegaLite, VegaDatasets
using Distributions, KernelDensity
using Contour
using Setfield
using VegaDatasets
using DataStructures
using DataTables
using Vega
using JSON

μ = [1.0,2.0]
Σ = [3.0 2.0;
     2.0 2.0]
d = Distributions.MultivariateNormal(μ,Σ)
samples = rand(d,300)';
data = DataTables.DataTable(x=samples[:,1],y=samples[:,2])
p = QuickVega.scatterplot(samples)



v = vlplot(mark=:circle,x=rand(10),y=rand(10),color=(value="red",))


# VegaLite.save()
# color=("value:'red'")

# output_dict = copy(v.params)
# spec = JSON.json(output_dict)

# open("foo.json","w") do f
#     JSON.print(f,spec)
# end

