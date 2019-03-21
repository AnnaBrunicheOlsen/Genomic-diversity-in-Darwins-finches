# make T-test for Tajimas D, Fus F and Fus D

df <- read.table("theta.thetasWindow_nooverlap.gz.pestPG", header =T)

# t-test Tajimas D
Tajima <- t.test(df$Tajima)

# t-test Fus F
FuF <- t.test(df$fuf)

# t-test Fus D
FuD <- t.test(df$fud)

output <- capture.output(print(Tajima),print(FuF),print(FuD))

writeLines(output, con = file("Tajima_results_nonoverlap.txt"))

# END
