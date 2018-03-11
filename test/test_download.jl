# This file is a part of JuliaFEM.
# License is MIT: see https://github.com/JuliaFEM/AbaqusReader.jl/blob/master/LICENSE

using AbaqusReader
using Base.Test

@testset "test abaqus_download" begin
    original_ENV = copy(ENV)
    delete!(ENV, "ABAQUS_DOWNLOAD_URL")
    delete!(ENV, "ABAQUS_DOWNLOAD_DIR")
    fn = tempname()
    touch(fn)
    model_name = basename(fn)
    ENV["ABAQUS_DOWNLOAD_DIR"] = dirname(fn)
    @test abaqus_download(model_name) == fn
    isfile(fn) && rm(fn)
    @test abaqus_download(model_name) == nothing
    ENV["ABAQUS_DOWNLOAD_URL"] = "https://models.com"
    @test abaqus_download(model_name; dryrun=true) == fn
    merge!(ENV, original_ENV)
end
