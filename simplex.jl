using LinearAlgebra

# Run this code simply by running in Julia repl. A is the matrix of coefficients, b is mx1 matrix \, c is the coefficients of the objective function, and B is the initial basis. The code will give you the tableau for each given basis.

A = [-2 1 1 0 0; 1 -2 0 1 0; 1 1 0 0 1]
b = [4, 2, 10]
c = [2, 3, 0, 0, 0]
B = [1, 2, 4]


# check B is basis
# if size(B)[1] > size(A)[2]
#     print("LP is infeasible")
# elseif det(A[:, B]) == 0
#     print("B is not a basis")

# else
    n = size(A)[2]
    Q = -inv(A[:, B]) * A[:, setdiff(1:n, B)]
    p = inv(A[:, B]) * b
    r = c[setdiff(1:n, B)] - transpose(transpose(c[B]) * inv(A[:, B]) * A[:, setdiff(1:n, B)])
    z0 = transpose(c[B]) * inv(A[:, B]) * b
    
    println("p = ", p)
    println("Q = ", Q)
    println("z0 = ", z0)
    println("r = ", r)

# end