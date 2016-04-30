# Chapter 2: Random Variable Generation (Book: Introducing Monte Carlo Methods with R)


# Ex 1: Simple simulations from uniform distribution
Nsim = 1000
x = runif(Nsim)
hist(x)


# Ex 2: Using inverse transform for generating exponential
#       distribution
Nsim = 10000
U    = runif(Nsim)
X    = -log(U)     # using inverse transforms
Y    = rexp(Nsim)
par(mfrow = c(1,2))
hist(X, freq = F, main = "Exponential from inverse transformation")
hist(Y, freq = F, main = "Exponential distribution using rexp()")


# Ex 3 (Excercise 2.2): Generating Logistic and Cauchy distribution