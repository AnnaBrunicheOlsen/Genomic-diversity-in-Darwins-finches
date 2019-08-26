library(tidyverse)
library(readxl)
library(lme4)
library(lmerTest)


dat <- read_excel('data/DarwinsFinches_22082019.xlsx') %>%
  mutate(Red_list = ifelse(RedListStatus == "LS", 0, 1),
         Area_z = c(scale(Islandareakm2)),
         Mass_z = c(scale(weight_gram))) %>%
  rename(Het = Heterozygosity_SFS)


mod <- lmer(log(Het) ~ Area_z + Mass_z + Red_list 
            + (1|Species) + (1|species_group),  
            data=dat)
summary(mod)


