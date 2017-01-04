program(pgm::Type{Val{:linear}}, t0::Float64, a::Float64=1.0) = k -> t0 / (1+a*k)
program(pgm::Type{Val{:quadratic}}, t0::Float64, a::Float64=1.0) = k -> t0 / (1+a*k^2)
program(pgm::Type{Val{:exp}}, t0::Float64, a::Float64=0.85) = k -> t0*a^k
program(pgm::Type{Val{:log}}, t0::Float64, a::Float64=1.1) = k -> t0 / (1+a*log(1+k))

program(pgm::Symbol, t0::Float64) = program(Val{pgm}, t0)
program(pgm::Symbol, t0::Float64, a::Float64) = program(Val{pgm}, t0, a)


doc"""
Cooling Scheduler and Temperature Management
"""
type CoolingScheduler
    T::Float64
    cycle::Int64
    process::Function
    cooling::Function
    isfrozen::Function

    function CoolingScheduler(pgm::Type{Val{Symbol}}, tmax=500::Float64, tmin=1::Float64, alpha=nothing)
        this = new()
        (this.T, this.cycle) = (tmax, 1)
        this.process = (alpha == nothing)? program(pgm, tmax) : program(pgm, tmax, this.alpha)
        this.isfrozen = () -> this.T <= tmin

        function cooling()
            this.T = this.process(this.cycle)
            cycle += 1
        end
        this.cooling = cooling

        return this
    end
end

CoolingScheduler(pgm::Symbol) = CoolingScheduler(Val{pgm})
CoolingScheduler(pgm::Symbol, tmax::Float64) = CoolingScheduler(Val{pgm}, tmax)
CoolingScheduler(pgm::Symbol, tmax::Float64, tmin::Float64) = CoolingScheduler(Val{pgm}, tmax, tmin)
CoolingScheduler(pgm::Symbol, tmax::Float64, tmin::Float64, alpha::Float64) = CoolingScheduler(Val{pgm}, tmax, tmin, alpha)
