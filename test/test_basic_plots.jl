@testset "Histogram plots" begin
    vector_plot = histogram([1.1, 1.2, 1.0, 2.0, 3.0, 2.1])
    @test vector_plot.mark == :bar

    cars = dataset("cars")
    table_plot = cars |> histogram(:Origin)
    @test table_plot.mark == :bar
end
