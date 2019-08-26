library(tidyverse)
library(readxl)
library(ggpubr)
library(gridExtra)

raw_data <- read_excel('../data/DarwinsFinches_22082019.xlsx')

ch <- cor.test(log(raw_data$Heterozygosity_SFS), log(raw_data$DOC))

colvals <- get_palette('npg',2)

ch_plot <- raw_data %>%
  ggplot(aes(x=log(DOC),y=log(Heterozygosity_SFS))) +
  geom_point(col=colvals[1]) +
  #ylab(expression(log(italic(H)))) +
  ylab('log(H)') +
  xlab('log(DOC)') +
  geom_smooth(method='lm',se=F,col=colvals[1]) +
  theme_bw() +
  theme(axis.title = element_text(size=14),
          axis.text = element_text(size=12),
          axis.title.x = element_text(margin=margin(b=3,t=3)),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          axis.line = element_line(colour = "black"),
          legend.position="none",
          legend.title = element_text(size=14)) +
  annotate("text",3.2,-5.4,label='italic(r) == -0.18',size=5, parse=T) +
  annotate("text",3.2,-5.55,label='italic(p) == 0.01',size=5, parse=T)


png('figS11.png',height=7,width=5,units='in', res=300)
ch_plot
dev.off()
