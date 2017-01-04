doc"""
Stability Counter
"""
type StabilityCounter
    counter::Int64
    ishalt::Function
    update::Function

    function StabilityCounter(halt=150::Int64, abs_tol=1e-12, rel_tol=1e-09)
        this = new()
        this.counter = 0
        this.ishalt = () -> this.counter >= halt

        function update(ΔE::Float64)
            if ΔE <= abs_tol #abs(ΔE) <= max(rel_tol * max(abs(a), abs(b)), abs_tol)
                this.counter += 1
            else
                this.counter = 0
            end
        end
        this.update = update
        return this
    end
end
