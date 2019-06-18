library(tidyverse)

raw <- read.table('../data/hetero_subsampling.txt',header=T) %>%
  filter(DOC %in% c(8,15)) %>%
  filter(rohNumber>0)

het <- raw %>%
  select(DOC,population,heteroAll) %>%
  spread(key=DOC, value=heteroAll) %>%
  mutate(pbias=(`8`-`15`)/`15`)

nsnv <- raw %>%
  select(DOC,population,SNPs) %>%
  spread(key=DOC, value=SNPs) %>%
  mutate(pbias=(`8`-`15`)/`15`)

rohn <- raw %>%
  select(DOC,population,rohNumber) %>%
  spread(key=DOC, value=rohNumber) %>%
  mutate(pbias=(`8`-`15`)/`15`)


rohl <- raw %>%
  select(DOC,population,rohLength) %>%
  spread(key=DOC, value=rohLength) %>%
  mutate(pbias=(`8`-`15`)/`15`)

##calc stats
calc_stats <- function(inp){
  mn <- mean(inp$pbias,na.rm=T)
  se <- sd(inp$pbias,na.rm=T) / length(na.omit(inp$pbias))
  c(mean=mn,lower=mn-1.96*se,upper=mn+1.96*se)
}

calc_stats(het)
calc_stats(nsnv)
calc_stats(rohn)
calc_stats(rohl)
