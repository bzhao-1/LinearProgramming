# Gomory-Cutting Planes Example 1(Example 11.1 from Bertsimas and Tsitsiklis)
# Khizar Qureshi, Ben Zhao, Nathan Streiff
# Professor Rob Thompson
# MATH 271 - Computational Matematics 

using JuMP, LinearAlgebra

# Variables
x1, x2, x3, x4, x5 = 0, 0, 0, 0, 0

# Function to compute Gomory Cut
function gomory_cut(A, B, b, c)
    n = size(A)[2]
    Q = -inv(A[:, B]) * A[:, setdiff(1:n, B)]
    p = inv(A[:, B]) * b
    r = c[setdiff(1:n, B)] - transpose(transpose(c[B]) * inv(A[:, B]) * A[:, setdiff(1:n, B)])
    z0 = transpose(c[B]) * inv(A[:, B]) * b

    println("p = ", p)
    println("Q = ", Q)
    println("z0 = ", z0)
    println("r = ", r)

    println("Optimal Solutions: ", p[1], ", ", p[2])

    if isinteger(p[1]) && isinteger(p[2])
        println("Integer Solutions we are finished")
        return
    else
        println("One or more optimal solutions are non-integer, We need to continue!")
    end

    return p, Q, z0
end



# Initial tableau
A = [-4 6 1 0; 1 1 0 1]
b = [9, 4]
c = [1, -2, 0, 0]
B = [1, 2]

# First Gomory Cut
p, Q, z0 = gomory_cut(A, B, b, c)
# 1.5 = x1 - 0.09x3 + 0.6x4
# 2.5 = x2 + 0.1x3 + 0.4x4
floor(value(p[2])) >= x2 - floor(-value(Q[2, 1])) * x3   - floor(-value(Q[2, 2])) * x4
println("Applying first cut: ", floor(value(p[2])), " >= x2 + ", floor(-value(Q[2, 1])), " * x3 + ", floor(-value(Q[2, 2])), " * x4", "\n")

# New tableau
A = [-4 6 1 0 0; 1 1 0 1 0; 0 1 0 0 1]
b = [9, 4, floor(value(p[2]))]
c = [1, -2, 0, 0, 0]
B = [1, 2, 4]

# Second Gomory Cut
p, Q, z0 = gomory_cut(A, B, b, c)
# 0.75 = x1 - 0.25x3 + 1.5x5
# 2 = x2 + 0x3 + 1x5
floor(value(p[1])) >= x1 -  ceil(Q[1,1]) * x3 - floor(value(Q[1, 2])) * x5
println("Applying second cut: ", floor(value(p[1])), " >= x1 - ", ceil(Q[1, 1]), " * x3 + ", floor(-value(Q[1, 2])), " * x5", "\n")

# New tableau
A = [-4 6 1 0 0; 1 1 0 1 0; 0 1 0 0 1; 1 0 -1 0 1]
b = [9, 4, 2, floor(value(p[1]))]
c = [1, -2, 0, 0, 0]
B = [1, 2, 4, 3]
gomory_cut(A, B, b, c)



