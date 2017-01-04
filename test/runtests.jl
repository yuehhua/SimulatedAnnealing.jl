using SimulatedAnnealing
using Base.Test

tests = ["stable",
         "cooling",
         ]

println("Running tests:")

for t in tests
    println(" * $(t)")
    include("$(t).jl")
end
