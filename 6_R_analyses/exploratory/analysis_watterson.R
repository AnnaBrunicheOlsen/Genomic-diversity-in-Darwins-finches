library(tidyverse)
library(readxl)
#library(weights)

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
        mutate(threatened=ifelse(Red_list_two=='treatened',1,0)) 

theta <- cbind(theta, df)

mod1 <- t.test(WattersonsThetaMean ~ threatened, data=theta) #t=2.2941,0.0305, negative effect

#x <- theta[theta$threatened==0,]
#y <- theta[theta$threatened==1,]

#mod2 <- wtd.t.test(x=x$WattersonsThetaMean, y=y$WattersonsThetaMean,
#                   weight=1/x$WattersponsThetaSD, 
#                   weighty=1/y$WattersponsThetaSD)

all_info <- read_excel('../data/heterozygosity_plink_12062019.xlsx',
                 sheet='DF_info') %>%
        mutate(population=paste0(species,'_',Island)) %>%
        group_by(population, weight_gram, Fu_Li_F, island_area_km2) %>%
        summarize() %>%
        ungroup()

theta <- cbind(theta,all_info[-6,])

mod_wt <- cor.test(theta$WattersonsThetaMean,theta$weight_gram) #r=-0.0888,p=0.6594
mod_is <- cor.test(theta$WattersonsThetaMean,theta$island_area_km2) #r=-0.041,0.8391
mod_f <- cor.test(theta$WattersonsThetaMean, theta$Fu_Li_F) #-0.3909,p=0.04379

## plot for SI

library(ggplot2)
library(ggpubr)
library(gridExtra)
library(cowplot)

colvals <- get_palette('npg',3)

plotA <- theta[,c(2,10)] %>%
  ggplot(aes(x=island_area_km2,y=WattersonsThetaMean)) +
  #geom_jitter() +
  geom_point(color=colvals[1]) +
  geom_smooth(method='lm',se=F,col=colvals[1]) +
  ylab(expression(italic(θ)[W])) +
  theme_bw() +
  xlab("Island area") +
  theme(#axis.title.x=element_blank(),
          axis.title=element_text(size=18),
          axis.text=element_text(size=14,color="black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          axis.line = element_line(colour = "black"),
          legend.position='none',
          strip.background =element_rect(fill="white"),
          strip.text = element_text(size=18)) +
  annotate("text",x=0,y=275,label='a)',size=5) +
  annotate("text",2000,275,label='italic(r) == -0.04',size=5, parse=T) +
  annotate("text",2000,260,label='italic(p) == 0.84',size=5, parse=T)

plotB <- theta[,c(2,8)] %>%
  ggplot(aes(x=weight_gram,y=WattersonsThetaMean)) +
  #geom_jitter() +
  geom_point(color=colvals[2]) +
  geom_smooth(method='lm',se=F,col=colvals[2]) +
  ylab(expression(italic(θ)[W])) +
  theme_bw() +
  xlab("Body size") +
  theme(#axis.title.x=element_blank(),
          axis.title=element_text(size=18),
          axis.text=element_text(size=14,color="black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          axis.line = element_line(colour = "black"),
          axis.title.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.text.y=element_blank(),
          legend.position='none',
          strip.background =element_rect(fill="white"),
          strip.text = element_text(size=18)) +
  annotate("text",x=10,y=275,label='b)',size=5) +
  annotate("text",20,275,label='italic(r) == -0.08',size=5, parse=T) +
  annotate("text",20,260,label='italic(p) == 0.66',size=5, parse=T)

plotC <- theta[,c(2,9)] %>%
  ggplot(aes(x=Fu_Li_F,y=WattersonsThetaMean)) +
  #geom_jitter() +
  geom_point(color=colvals[3]) +
  geom_smooth(method='lm',se=F,col=colvals[3]) +
  ylab(expression(italic(θ)[W])) +
  theme_bw() +
  xlab(expression("Fu's"~italic(F))) +
  theme(#axis.title.x=element_blank(),
          axis.title=element_text(size=18),
          axis.text=element_text(size=14,color="black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          axis.title.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.text.y=element_blank(),
          axis.line = element_line(colour = "black"),
          legend.position='none',
          strip.background =element_rect(fill="white"),
          strip.text = element_text(size=18)) +
  annotate("text",x=-0.9,y=275,label='c)',size=5) +
  annotate("text",-0.25,275,label='italic(r) == -0.39',size=5, parse=T) +
  annotate("text",-0.25,260,label='italic(p) == 0.043',size=5, parse=T)

tiff('fig_S15.tiff',height=5,width=10,units='in',res=300,compression='lzw')

plot_grid(plotA,plotB,plotC, ncol=3, rel_widths=c(0.38,0.31,0.31))

dev.off()
