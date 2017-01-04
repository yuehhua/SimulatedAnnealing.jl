abstract State

immutable StatePair
    current::State
    proposal::State
end

immutable ConcreteState <: State  # move out
    value::Float64
end
