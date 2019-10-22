# use SFS to estimate theta for each population
data <- read.table("out.sfs", header=F)
all <- sum(data)
col2 <- sum(data$V2)
theta <- col2/all

# theta =4Neu
Neu <- theta/4

# mut rate from Lamichaney et al 2015  1.05×10−8 substitutions per generation
# 5 year generation time from Grant & Grant 1992
# 1.05x10-8/5 = 2.1x10-9 substitutions per base pair per year
effN <- Neu/2.1E-9

write.table(effN, file = "Ne.txt", row.names = F, col.names = F)

# END