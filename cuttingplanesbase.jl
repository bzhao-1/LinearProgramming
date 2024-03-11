# Gomory-Cutting Planes Example
# Khizar Qureshi, Ben Zhao, Nathan Streiff
# Professor Rob Thompson
# MATH 271 - Computational Matematics 

using JuMP, LinearAlgebra

x1 = 0
x2 = 0
x3 = 0
x4 = 0
x5 = 0


# Get optimal tableau
A = [-4 6 1 0; 1 1 0 1]
b = [9, 4]
c = [1, -2, 0, 0]
B = [1, 2]



if size(B)[1] > size(A)[2]
    print("LP is infeasible")
elseif det(A[:, B]) == 0
    print("B is not a basis")

else
    n = size(A)[2]
    Q = -inv(A[:, B]) * A[:, setdiff(1:n, B)]
    p = inv(A[:, B]) * b
    r = c[setdiff(1:n, B)] - transpose(transpose(c[B]) * inv(A[:, B]) * A[:, setdiff(1:n, B)])
    z0 = transpose(c[B]) * inv(A[:, B]) * b
    
    println("p = ", p)
    println("Q = ", Q)
    println("z0 = ", z0)
    println("r = ", r, "\n")

    println("Optimal Solutions: ",p[1], ", ", p[2])

    if isinteger(p[1]) && isinteger(p[2])
        println("Integer Solutions we are finished")
    else
        println("One or more values is non integer, We need to continue!")
    end

end

# Extract tableau from vectors
# Add Gomory cut by taking integer values
floor(value(p[2])) >= x2 - floor(-value(Q[2, 1])) * x4   - floor(-value(Q[2, 2])) * x3
println("Applying first cut: ", floor(value(p[2])), " >= x2 + ", floor(-value(Q[2, 1])), " * x4 + ", floor(-value(Q[2, 2])), " * x3")


# Get optimal tableau
A = [-4 6 1 0 0; 1 1 0 1 0; 0 1 0 0 1]
b = [9, 4, floor(value(p[2]))]
c = [1, -2, 0, 0, 0]
B = [1, 2, 4]



if size(B)[1] > size(A)[2]
    print("LP is infeasible")
elseif det(A[:, B]) == 0
    print("B is not a basis")

else
    n = size(A)[2]
    Q = -inv(A[:, B]) * A[:, setdiff(1:n, B)]
    p = inv(A[:, B]) * b
    r = c[setdiff(1:n, B)] - transpose(transpose(c[B]) * inv(A[:, B]) * A[:, setdiff(1:n, B)])
    z0 = transpose(c[B]) * inv(A[:, B]) * b
    
    println("p = ", p)
    println("Q = ", Q)
    println("z0 = ", z0)
    println("r = ", r)

    println("Optimal Solutions: ",p[1], ", ", p[2])

    if isinteger(p[1]) && isinteger(p[2])
        println("Integer Solutions we are finished")
    else
        println("One or more values is non integer, We need to continue!")
    end
end

# Add second cut
# x1 - 1/4 x3 + 6/4 x5 = 3/4
floor(value(p[1])) >= x1 -  ceil(Q[1,1]) * x3 - floor(value(Q[1, 2])) * x5


# Get optimal tableau
A = [-4 6 1 0 0; 1 1 0 1 0; 0 1 0 0 1; 1 0 -1 0 1]
b = [9, 4, 2, floor(value(p[1]))]
c = [1, -2, 0, 0, 0]
B = [1, 2, 4, 3]



if size(B)[1] > size(A)[2]
    print("LP is infeasible")
elseif det(A[:, B]) == 0
    print("B is not a basis")

else
    n = size(A)[2]
    Q = -inv(A[:, B]) * A[:, setdiff(1:n, B)]
    p = inv(A[:, B]) * b
    r = c[setdiff(1:n, B)] - transpose(transpose(c[B]) * inv(A[:, B]) * A[:, setdiff(1:n, B)])
    z0 = transpose(c[B]) * inv(A[:, B]) * b
    
    println("p = ", p)
    println("Q = ", Q)
    println("z0 = ", z0)
    println("r = ", r)
    println("Optimal Solutions: ",p[1], ", ", p[2])

    if isinteger(p[1]) && isinteger(p[2])
        println("Integer Solutions we are finished")
    else
        println("One or more values is non integer, We need to continue!")
    end
end







