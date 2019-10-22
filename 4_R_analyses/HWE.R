# plot results from PCAngsd

# see http://www.popgen.dk/albrecht/phdcourse/html/BAG2018PCA.html#sec7
# see SI from Meisner et al 2019

library(RcppCNPy)
library(tidyverse)
library(reshape2)

# F > 0 excess of homo
# F < 0 excess of hetero

# inbreeding per site
S <- as.data.frame(npyLoad("species.inbreed.sites.npy"))
LRT <- as.data.frame(npyLoad("species.lrt.sites.npy"))
sitesF <- cbind(S,LRT)
colnames(sitesF) <- c("F", "LRT")

sites <- nrow(sitesF)

a <- mean(sitesF$F)
s <- sd(sitesF$F)
error <- qnorm(0.975)*s/sqrt(sites)
left <- a-error
right <- a+error

df <- cbind(a,s,left,right)

write.table(df, file = "inbreeding.txt", row.names = F, col.names = F)


# END
