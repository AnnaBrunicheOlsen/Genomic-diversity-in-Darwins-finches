library(tidyverse)
library(readxl)

df <- read_csv('data/df.csv')

neb <- read_excel('data/Neb.xlsx') %>%
  filter(Neb != 'Infinite')

neb <- neb[-7,]

neb <- cbind(neb, df)


mod1 <- lm(logNeb ~ Red_list_two, data=neb)
summary(mod1)
mod2 <- lm(logNeb ~ Red_list_two, weights=sample_size, data=neb)
summary(mod2)
