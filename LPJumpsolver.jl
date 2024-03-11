# 
using JuMP, GLPK

# Preparing an optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, x1 >= 0)
@variable(m, x2 >= 0) 
@variable(m, x3 >= 0)
@variable(m, x4 >= 0)
@variable(m, x5 >= 0)
@variable(m, x6 >= 0)
@variable(m, x7 >= 0)

# Setting the objective
@objective(m, Max, x1 + 2x2)

# Adding constraints
@constraint(m, constraint1, -3x1+4x2 + x3 == 4)
@constraint(m, constraint2, 3x1+2x2 + x4== 11)
@constraint(m, constraint3, 2x1-x2 + x5 == 5)
@constraint(m, constraint4, x2 + x6 == 2)
@constraint(m, constraint5, x1 - x6 + x7 == 2)



# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))

