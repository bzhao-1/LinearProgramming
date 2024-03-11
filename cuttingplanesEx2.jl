# Gomory-Cutting Planes Example 2 (11.1 Exercise from Bertsimas and Tsitsiklis)
# Khizar Qureshi, Ben Zhao, Nathan Streiff
# Professor Rob Thompson
# MATH 271 - Computational Matematics 

using JuMP, LinearAlgebra

# Variables
x1, x2, x3, x4, x5, x6, x7 = 0, 0, 0, 0, 0, 0, 0

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
A = [-3 4 1 0 0; 3 2 0 1 0; 2 -1 0 0 1]
b = [4, 11, 5]
c = [1, 2, 0, 0, 0]
B = [1, 2, 5]

# First Gomory Cut
p, Q, z0 = gomory_cut(A, B, b, c)
floor(value(p[2])) >= x2 - floor(-value(Q[2, 1])) * x3   - floor(-value(Q[2, 2])) * x4
println("Applying first cut: ", floor(value(p[2])), " >= x2 + ", floor(-value(Q[2, 1])), " * x3 + ", floor(-value(Q[2, 2])), " * x4", "\n")

# New tableau
A = [-3 4 1 0 0 0; 3 2 0 1 0 0; 2 -1 0 0 1 0; 0 1 0 0 0 1]
b = [4, 11, 5, 2]
c = [1, 2, 0, 0, 0, 0]
B = [1, 2, 5, 3]

# Second Gomory Cut
p, Q, z0 = gomory_cut(A, B, b, c)
floor(value(p[1])) >= x1 -  ceil(Q[1,1]) * x3 - floor(value(Q[1, 2])) * x5
println("Applying second cut: ", floor(value(p[1])), " >= x1 + ", floor(-value(Q[1, 1])), " * x4 + ", ceil(Q[1, 2]), " * x6", "\n")

# New tableau
A = [-3 4 1 0 0 0 0; 3 2 0 1 0 0 0; 2 -1 0 0 1 0 0; 0 1 0 0 0 1 0; 1 0 0 0 0 1 1]
b = [4, 11, 5, 2, 2]
c = [1, 2, 0, 0, 0, 0, 0]
B = [1, 2, 5, 3, 4]
gomory_cut(A, B, b, c)



