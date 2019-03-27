library(tidyverse)
library(readxl)

f_data <- read_csv('data/f_14122028.csv') %>%
  unite(pop, c('species.x','Island')) %>%
  group_by(pop, Red_list_two.x, F, Fu_Li_F) %>%
  summarize() %>%
  mutate(Fcat = ifelse(F=='decline',1,0))

test <- glm(Fcat ~ Red_list_two.x, family='binomial',data=f_data)
summary(test)

table(f_data$Red_list_two.x,f_data$F)

library(logistf)


test <- logistf(Fcat ~ Red_list_two.x, data=f_data)
summary(test)


con_test <- lm(Fu_Li_F ~ Red_list_two.x, data=f_data)
summary(con_test)
