source("sbm.R")

# general parameter setup
sigma = 0.1
x0 = (sqrt(5)-1)/2
n = 1000
budgets = exp(seq(log(50),log(5000),length.out=40))
kappas = c(1.5,2,2.5,3)
xs = list()

for (kappa in kappas) {
	g = function(x) rnorm(1,abs(x-x0)^(kappa-1)*sign(x-x0),sigma)
	temp = matrix(0,nrow=n,ncol=length(budgets))
	pb = txtProgressBar(style=3)
	for (k in 1:length(budgets)) {
		for (i in 1:n) {
			temp[i,k] = sbm(g,0,1,budget=budgets[k],pval.plot=FALSE,trace=FALSE)	
		}
		setTxtProgressBar(pb,k/length(budgets))
	}
	close(pb)
	xs[[paste0("kappa_",kappa)]] = temp
}