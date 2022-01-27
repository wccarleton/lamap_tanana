poisRegCode <- nimbleCode({
   if(K > 1){
      A[1:K,1:K] <- inverse(diag(x=rep(1000,K)))
      multimu[1:K] <- rep(0,K)
      B[1:K] ~ dmnorm(mean=multimu[1:K], prec=A[1:K,1:K])
   }else{
      B ~ dnorm(mean=0,sd=1000)
   }
   for (j in 1:N){
      if(K > 1){
         lambda[j] <- inprod(X[j,1:K], B[1:K])
      }else{
         lambda[j] <- X[j] * B
      }
   }
   for (j in 1:N){
      Y[j] ~ dpois(exp(lambda[j]))
   }
})

Y <- lamap_class_sites_mat[,2]
N <- length(Y)
X <- cbind(rep(1,N),lamap_class_sites_mat[,1])
K <- ncol(X)

poisRegData <- list(Y=Y,
                  X=X)

poisRegConsts <- list(N=N,
                     K=K)

poisRegInits <- list(B=rep(0,K))

poisRegModel <- nimbleModel(code=poisRegCode,
                        data=poisRegData,
                        inits=poisRegInits,
                        constants=poisRegConsts)

#compile nimble model to C++ code—much faster runtime
C_poisRegModel <- compileNimble(poisRegModel, showCompilerOutput = FALSE)

#configure the MCMC
poisRegModel_conf <- configureMCMC(poisRegModel)

#select the variables that we want to monitor in the MCMC chain
#poisRegModel_conf$addMonitors(c("lambda"))

#build MCMC
poisRegModelMCMC <- buildMCMC(poisRegModel_conf,thin=1,enableWAIC = TRUE)

#compile MCMC to C++—much faster
C_poisRegModelMCMC <- compileNimble(poisRegModelMCMC,project=poisRegModel)

#number of MCMC iterations
niter=20000

#set seed for replicability
set.seed(1)

#call the C++ compiled MCMC model
C_poisRegModelMCMC$run(niter)

#save the MCMC chain (monitored variables) as a matrix
samples <- as.matrix(C_poisRegModelMCMC$mvSamples)

WAIC <- C_poisRegModelMCMC$calculateWAIC(nburnin=5000)

posterior_Y <- c()
for(j in 1:1000){
   C_poisRegModel$simulate(C_poisRegModel$getDependencies("Y"))
   C_poisRegModel$simulate("Y",includeData=TRUE)
   posterior_Y <- cbind(posterior_Y,C_poisRegModel$Y)
}
posterior_Y_ci <- cbind(1:5,t(apply(posterior_Y,1,quantile,probs=c(0.01,0.05,0.5,0.95,0.99))))
