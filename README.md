# QuickVega.jl <img align="right" src="./images/quickvega_logo.png" height="150"></img>


QuickVega is a Julia high-level visualization library with Vega-Lite as a backend.
The goal of this library is to do *easy and beautiful* visualizations,
similarly to the [ Seaborn ]( https://github.com/mwaskom/seaborn ) python library.
Hence, QuickVega is a wrapper to
[VegaLite.jl]( https://github.com/queryverse/VegaLite.jl )
, providing ready-to-use visualizations.

## Proposed wishlist:
- [ ] Scatter plot;
- [ ] Line plot;
- [ ] Bar plot;
- [ ] Histogram 1D;
- [ ] Histogram 2D;
- [ ] Density(KDE) plot;
- [ ] Countour Plot;
- [ ] Joint Plot;
- [ ] Box Plot;
- [ ] Aggregate flag, allowing for easy plot for "counting","sum", "meand", "median";
- [ ] Define a general `kwargs` for default plot functions, allowing
an easy way to choose colors, widths, title, etc;
- [ ] Create function to export Vega-Lite specification
for every plot function;
- [ ] Create plot function for graph visualizations;
- [ ] Allow plotting various images one over the other, similar to
other plotting libraries, .i.e:
```julia
QuickVega.plot(x,y,label="Plot1")
QuickVega.plot(w,z,label="Plot2")
# This creates one plot with two series
```
- [ ] Allow easy plot of functions, similar to Plots.jl, .i.e:
```julia
Plots.plot(x -> x^2, 1,2)
```
- [ ] Make loading visualization more efficient (takes to long to plot
the same graph)

