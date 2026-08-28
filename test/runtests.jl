using Test
using QuickVega
using VegaLite
using VegaLite: Vega

@testset "QuickVega v1" begin
    data = (
        x=[1, 2, 3, 4],
        y=[2, 4, 3, 5],
        grp=["a", "a", "b", "b"],
    )

    @testset "qscatter" begin
        p = qscatter(data; x=:x, y=:y, color=:grp)
        spec = Vega.getparams(p)

        @test p isa VegaLite.VLSpec
        @test spec["mark"]["type"] == "point"
        @test spec["encoding"]["x"]["field"] == "x"
        @test spec["encoding"]["x"]["type"] == "quantitative"
        @test spec["encoding"]["y"]["field"] == "y"
        @test spec["encoding"]["color"]["field"] == "grp"
    end

    @testset "qline" begin
        p = qline(data; x=:x, y=:y, color=:grp)
        spec = Vega.getparams(p)

        @test p isa VegaLite.VLSpec
        @test spec["mark"]["type"] == "line"
        @test spec["encoding"]["x"]["field"] == "x"
        @test spec["encoding"]["y"]["field"] == "y"
        @test spec["encoding"]["color"]["field"] == "grp"
    end

    @testset "qbar" begin
        p = qbar(data; x=:grp)
        spec = Vega.getparams(p)

        @test p isa VegaLite.VLSpec
        @test spec["mark"]["type"] == "bar"
        @test spec["encoding"]["x"]["field"] == "grp"
        @test spec["encoding"]["y"]["aggregate"] == "count"

        p2 = qbar(data; x=:grp, y=:y)
        spec2 = Vega.getparams(p2)
        @test spec2["encoding"]["y"]["field"] == "y"
        @test !haskey(spec2["encoding"]["y"], "aggregate")
    end

    @testset "qhist" begin
        p = qhist(data; x=:x)
        spec = Vega.getparams(p)

        @test p isa VegaLite.VLSpec
        @test spec["mark"]["type"] == "bar"
        @test spec["encoding"]["x"]["field"] == "x"
        @test spec["encoding"]["x"]["bin"] == true
        @test spec["encoding"]["y"]["aggregate"] == "count"

        p2 = qhist(data; x=:x, bins=12)
        spec2 = Vega.getparams(p2)
        @test spec2["encoding"]["x"]["bin"]["maxbins"] == 12

        @test_throws ArgumentError qhist(data; x=:x, bins="bad")
    end
end
