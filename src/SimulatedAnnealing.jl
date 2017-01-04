__precompile__()

module SimulatedAnnealing

    export

    program,
    CoolingScheduler,

    StabilityCounter,

    State,
    StatePair,
    ConcreteState,

    update,
    get_acceptance,
    MH_init,
    MH_body!,
    MH_algorithm,

    boltzmann_factor,
    acceptance,
    SA_algorithm

    include("cooling.jl")
    include("stable.jl")
    include("state.jl")
    include("mh.jl")
    include("sa.jl")

end # module
