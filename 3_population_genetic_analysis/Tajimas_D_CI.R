# make T-test for Tajimas D, Fus F and Fus D

df <- read.table("out.thetas.idx.pestPG", header =T)

# t-test Tajimas D
Tajima <- t.test(df$Tajima)

# t-test Fus F
FuF <- t.test(df$fuf)

# t-test Fus D
FuD <- t.test(df$fud)

output <- capture.output(print(Tajima),print(FuF),print(FuD))

writeLines(output, con = file("Tajima_results.txt"))


# END
