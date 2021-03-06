# CHAPTER 2: Random Variable Generation (Book: Introducing Monte Carlo Methods with R)


#------------------------------- Inverse Transform -----------------------------------


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


# Ex 3 (Excercise 2.2): Generating Logistic distribution with inverse 
#                       transform
Nsim = 10^4
U    = runif(Nsim)
X    = -log(1.0/U-1)
Y    = rlogis(Nsim)
par(mfrow = c(1,2))
hist(X, freq = F, main = "Logistic from inverse transformation")
hist(Y, freq = F, main = "Logistic distribution using rlogis()")


#---------------------------------- Normal distribution & CLT ---------------------------------

# Ex 4: Using CLT for simulating standard normal 
#       distribution
norm.clt <- function()
{
	# Generate approximation of normal distribution using
	# Central Limit Theorem
	U    = runif(12) - 0.5
    Z    = sum(U)  #  E(Z) = 0  and  Var(Z) = 1
    return (Z)
}

Nsim = 1000
X    = replicate(Nsim,norm.clt(),simplify = "array")
Y    = rnorm(Nsim)
par(mfrow = c(1,2))
hist(X, freq = F, main = "Normal distribution simulation using CLT")
hist(Y, freq = F, main = "R function for normal distribution simulation") 

# ? In excercise is is said to compare tails of distributions, but they do seem similar


#------------------------------------- Accept - Reject Method -------------------------------

# Ex 5: Generate beta random variable using uniform 
#       distribution as proposal
rbeta.uniform <- function(nsim, alpha, beta)
{
	# select tight bound by finding maximum of beta dist with given parameters
	Max = optimize(f = function(x){dbeta(x,alpha,beta)}, interval = c(0,1), maximum = TRUE)$objective
	bound = 1/Max
	
	sample  = rep(0,times = nsim)
	accepts = 0
	while(accepts != nsim){
		
			# define proposal distribution as uniform
	        U.proposal = runif(1)
	
	        # generate uniform distribution for accept-reject
	        U.accept   = runif(1)
	        
	        if (U.accept <= bound * dbeta(U.proposal,alpha,beta))
	        {
	        	sample[accepts+1] = U.proposal
	        	accepts  = accepts + 1
	        } 
	        
	}
    return(sample)
}

Nsim  = 10000
alpha = 2  # shape parameters
beta  = 3
X     = rbeta(Nsim,alpha,beta)
y     = rbeta.uniform(Nsim,alpha,beta)
par(mfrow = c(1,2))
hist(X, freq = F, main = "Beta distribution using R function")
hist(y, freq = F, main = "Beta distribution through accept-reject procedure") 







