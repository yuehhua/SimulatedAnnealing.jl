#
# CoolingScheduler
#

g = program(:linear, 100.0)
@test g(1) == 50.0
@test g(3) == 25.0
@test g(4) == 20.0
@test g(7) == 12.5

g = program(:quadratic, 100.0)
@test g(1) == 50.0
@test g(3) == 10.0
@test g(7) == 2.0
@test g(1) == 50.0


sch = CoolingScheduler()
