function get_acceptance(acceptance_dist)
    acceptance(states::StatePair) = min(1, acceptance_dist(states))
    return acceptance
end

function update(states::StatePair, alpha::Float64)::State
    u = rand()
    if u <= alpha
        return states.proposal
    else
        return states.current
    end
end

function MH_init(init::Function, x=State[])
    push!(x, init())
    return x
end

function MH_body!(x::Vector{State}, next_state::Function, acceptance::Function, markov_step::Int64)
    for i in 1:markov_step
        states = StatePair(x[i], next_state())
        alpha = acceptance(states)
        push!(x, update(states, alpha))
    end
    return x
end

doc"""
Metropolis-Hastings algorithm
"""
function MH_algorithm(initiate::Function, next_state::Function, acceptance::Function, markov_step::Int64=10000)
    x = MH_init(initiate)
    MH_body!(x, next_state, acceptance, markov_step)
    return x
end
