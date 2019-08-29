library(tidyverse)
library(readxl)
library(lme4)
library(lmerTest)
library(ggplot2)
library(ggpubr)

dat <- read_excel('../data/DarwinsFinches_22082019.xlsx') %>%
  mutate(Red_list = ifelse(RedListStatus == "LS", 0, 1),
         Area_z = c(scale(Islandareakm2)),
         Mass_z = c(scale(weight_gram))) %>%
  rename(Het = Heterozygosity_SFS)


mod <- lmer(log(Het) ~ Area_z + Mass_z + Red_list 
            + (1|Species) + (1|species_group),  
            data=dat)
s <- summary(mod)$coefficients[-1,]
s <- s[c(2,1,3),]

fig_data <- data.frame(Covariate=c('Body size','Island area','Red list status'),
                       Estimate=s[,1],
                       Lower=s[,1] - 1.96*s[,2], Upper=s[,1]+1.96*s[,2])

cols <- get_palette('npg',1)

out <- fig_data %>%
  mutate(Covariate = factor(Covariate, 
          levels=c('Island area','Body size','Red list status'))) %>%
  ggplot(aes(x=Covariate, y=Estimate)) +
  geom_hline(yintercept=0,linetype=2) +
  geom_point(col=cols,size=4) +
  geom_errorbar(aes(ymin=Lower, ymax=Upper), col=cols,
                size=1, width=0.2) +
  ylab('Effect Size ± 95% CI') +
  theme_bw() +
  theme(axis.title.x=element_blank(),
          axis.title=element_text(size=18),
          axis.text=element_text(size=18,color="black"),
          #panel.border = element_blank(), 
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), 
          axis.line = element_line(colour = "black"),
          legend.position='none')

ggsave('fig3_effectsize.png', width=7,height=7)
