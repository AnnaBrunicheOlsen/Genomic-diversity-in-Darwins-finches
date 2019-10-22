# use SFS to estimate heterozygosity for each individual
#in R
a<-scan("out.ml")
het <- a[2]/sum(a)

write.table(het, file = "het.txt", row.names = F, col.names = F)

# END
