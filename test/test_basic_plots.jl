@testset "Histogram plots" begin
    vector_plot = histogram([1.1, 1.2, 1.0, 2.0, 3.0, 2.1])
    @test vector_plot.mark == :bar

    cars = dataset("cars")

    table_plot_with_bin = histogram(cars, :Miles_per_Gallon)
    table_plot_no_bin = histogram(cars, :Origin, use_bin=false)

    @test table_plot_with_bin.mark == :bar
    @test table_plot_no_bin.mark == :bar
end
