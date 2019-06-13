library(tidyverse)
library(readxl)
library(weights)

theta <- read_excel('../data/heterozygosity_plink_12062019.xlsx',
                 sheet='wattersonsTheta') %>%
        arrange(population)
theta <- theta[1:27,]

df <- read_excel('../data/heterozygosity_plink_12062019.xlsx',
                 sheet='DF_info') %>%
        mutate(population=paste0(species,'_',Island)) %>%
        group_by(population, Red_list_two) %>%
        summarize() %>%
        ungroup() %>%
        mutate(Red_list_two=ifelse(Red_list_two=='treatened',1,0)) %>%
        pull(Red_list_two)

theta <- cbind(theta, threatened=df)

mod1 <- t.test(WattersonsThetaMean ~ threatened, data=theta)

x <- theta[theta$threatened==0,]
y <- theta[theta$threatened==1,]

mod2 <- wtd.t.test(x=x$WattersonsThetaMean, y=y$WattersonsThetaMean,
                   weight=1/x$WattersponsThetaSD, 
                   weighty=1/y$WattersponsThetaSD)
