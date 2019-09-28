library(tidyverse)
library(ggpubr)
library(gridExtra)
library(readxl)

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

theta <- cbind(theta, threatened=df) %>%
        mutate(Red_list = ifelse(threatened==1,'Threatened','Non-threatened'))

mod1 <- t.test(WattersonsThetaMean ~ threatened, data=theta)

pval <- mod1$p.value

boxpl <- theta %>%
  ggplot(aes(x=Red_list,y=WattersonsThetaMean, fill=Red_list, color=Red_list)) +
  #geom_jitter() +
  #geom_violin(alpha=0.6,draw_quantiles=0.5) +
  geom_boxplot(alpha=0.6) +
  scale_fill_manual(values=get_palette("npg",2)) +
  scale_color_manual(values=get_palette("npg",2)) +
  #ylab('log(Neb)') +
  ylab(expression(italic(θ)[W])) +
  theme_bw() +
  xlab("Status") +
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
  annotate("text",x=1.5,y=2.5,label=paste('P =',round(pval,2)),size=5.5) #+
  #annotate("text",x=0.6,y=2.5,label="b)",size=6)

ggsave('fig5_wtheta.png',height=7,width=4)
