# QuickVega.jl <img align="right" src="./images/quickvega_logo.png" height="150"></img>


QuickVega is a Julia high-level visualization library with Vega-Lite as a backed. Although there exists many plotting libraries in the Julia community,
the goal of this library is to do *easy and beautiful* visualizations, similarly to the [ Seaborn ]( https://github.com/mwaskom/seaborn ) python library.
For achieving this goal, [VegaLite.jl]( https://github.com/queryverse/VegaLite.jl ) is of great help, since it already provides a beatiful and resourceful plotting library.
One of the problems with Vega-Lite though, is that it's customizability leaves users to do a lot of coding (very verbose).

This is where QuickVega comes in. It provides a high-level wrapper, providing ready-to-use visualizations.
