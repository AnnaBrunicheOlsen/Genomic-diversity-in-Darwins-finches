library(tidyverse)
library(ggpubr)
library(gridExtra)

df <- read_csv('../data/df.csv') %>%
  mutate(Red_list = ifelse(Red_list_two=='treatened',
                           'Threatened','Non-threatened'),
         Red_list = factor(Red_list,levels=c("Threatened","Non-threatened")))

test <- t.test(logNeb~Red_list_two, data=df)
pval <- test$p.value

boxpl <- df %>%
  ggplot(aes(x=Red_list,y=logNeb, fill=Red_list, color=Red_list)) +
  #geom_jitter() +
  geom_boxplot(alpha=0.6) +
  scale_fill_manual(values=get_palette("npg",2)) +
  scale_color_manual(values=get_palette("npg",2)) +
  #ylab('log(Neb)') +
  ylab(expression(log(italic(N)[eb]))) +
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

ggsave('fig5_Neb.png',height=7,width=7)
