doc"""
f(state) = exp{E / kT} is known as Boltzmann distribution.
The ratio of f(state1) and f(state2) is known as Boltzmann factor.
"""
function boltzmann_factor(g::Function, temperature::Float64)
    if temperature == 0.0
        return 0.0
    end
    ΔE = g()
    if ΔE < 0.0
        return 1.0
    end
    return exp(-ΔE / temperature)
end

function acceptance(sym::Type{Val{:energy}}, f::Function, states::StatePair, temperature::Float64)
    g = () -> f(states.proposal) - f(states.current)
    return boltzmann_factor(g, temperature)
end

function acceptance(sym::Type{Val{:loss}}, f::Function, states::StatePair, temperature::Float64)
    g = () -> f(states.proposal, states.current)
    return boltzmann_factor(g, temperature)
end

acceptance(sym::Symbol, f::Function, states::StatePair, temperature::Float64) = acceptance(Val{sym}, f, states, temperature)

type SAConfig
    initiate::Function
    func::Function
    func_type::Symbol
    next_state::Function
    acceptance::Function
    # markov_step=10000::Int64
    # T_0 = 10000
end

doc"""
simulated annealing algorithm
"""
function SA_algorithm()
    x = MH_init(initiate)
    cool_sch = CoolingScheduler()
    stable_counter = StabilityCounter()
    while !cool_sch.isfrozen() && !stable_counter.ishalt()
        MH_body!(x, next_state, acceptance, markov_step)
        cool_sch.cooling()
        stable_counter.update()
    end
    return x
end
