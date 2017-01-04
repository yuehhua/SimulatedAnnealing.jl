#
# StabilityCounter
#

counter = StabilityCounter()
@test counter.update(1e-10) == 0
@test counter.update(1e-13) == 1
@test counter.update(1e-13) == 2
@test counter.update(1e-10) == 0

for i=1:149
    counter.update(1e-13)
end

@test counter.ishalt() == false
counter.update(1e-13)
@test counter.ishalt() == true
