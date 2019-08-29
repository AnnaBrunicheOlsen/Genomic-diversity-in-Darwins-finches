library(tidyverse)
library(readxl)
library(ggpubr)
library(gridExtra)

raw_data <- read_excel('../data/DarwinsFinches_22082019.xlsx')

fig_data <- raw_data %>%
  mutate(island_code = ifelse(is.na(island_code), '',island_code),
         Population = ifelse(island_code=='',Species,
                             paste(Species,island_code,sep='_')),
         Population = str_replace_all(Population,'_',' ')) %>%
  mutate(Species = str_replace(Species,"_"," ")) %>%
  mutate(Population = factor(Population),
         Population = factor(Population,levels=rev(levels(Population)))) %>%
  rename(het = Heterozygosity_SFS) 

het <- fig_data %>%
  ggplot(aes(x=Population,y=het,fill=Species,col=Species)) +
    geom_boxplot(alpha=0.6) +
    #geom_violin(alpha=0.6) +
    scale_fill_manual(values=get_palette("npg",17)) +
    scale_color_manual(values=get_palette("npg",17)) +
    coord_flip() +
    ylab(expression(italic(H))) +
    theme_bw() +
    theme(axis.title = element_text(size=14),
          axis.text = element_text(size=10),
          axis.title.x = element_text(margin=margin(b=5,t=4.5)),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          axis.line = element_line(colour = "black"),
          axis.text.y = element_blank(),
          axis.title.y = element_blank(),
          axis.ticks.y = element_blank(),
          legend.position="none",
          plot.margin = margin(7,12,7,7),
          legend.title = element_text(size=14)) +
  annotate("text",27,0.005,label="c)",size=6)

size <- fig_data %>%
  ggplot(aes(x=Population,y=weight_gram,fill=Species,col=Species)) +
  geom_point(size=3) +
  scale_color_manual(values=get_palette("npg",17)) +
  scale_fill_manual(values=get_palette("npg",17)) +
  coord_flip() +
  ylab("Body size (g)") +
  theme_bw() +
  theme(axis.title = element_text(size=14),
        axis.text = element_text(size=10),
        axis.title.x = element_text(margin=margin(b=5,t=5)),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.position="none",
        legend.title = element_text(size=14)) +
  annotate("text",27,30,label="a)",size=6)

area <- fig_data %>%
  ggplot(aes(x=Population,y=Islandareakm2,fill=Species,col=Species)) +
  geom_point(size=3) +
  scale_color_manual(values=get_palette("npg",17)) +
  scale_fill_manual(values=get_palette("npg",17)) +
  coord_flip() +
  ylab(expression(Island~area~(km^2))) +
  theme_bw() +
  theme(axis.title = element_text(size=14),
        axis.text = element_text(size=10),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.position="none",
        legend.title = element_text(size=14)) +
  annotate("text",27,4000,label="b)",size=6)

png('fig3_overview.png',height=7,width=10,units='in',res=300)
grid.arrange(size,area,het,ncol=3,widths=c(1.8,1,1))
dev.off()
