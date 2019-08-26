library(tidyverse)
library(readxl)
library(ggpubr)
library(gridExtra)

raw_data <- read_excel('../data/DarwinsFinches_22082019.xlsx') %>%
  mutate(is_outgroup = case_when(
            Species %in% c('Tiaris_bicolor','Loxigilla_noctis') ~ 'Outgroup',
            TRUE ~ 'Ingroup')) %>%
  rename(het = Heterozygosity_SFS) 

pval <- t.test(log(mapping_percentage) ~ is_outgroup, data=raw_data)$p.value

ann_text <- data.frame(x=1.5,y=c(4.62,0),
                       lab=paste('P =',sprintf("%.2f",round(pval,2))),
                       is_outgroup="Ingroup")

map <- raw_data %>%

  ggplot(aes(x = is_outgroup, y = log(mapping_percentage), 
             fill=is_outgroup,color=is_outgroup)) +
    geom_boxplot(alpha=0.6) +
    scale_fill_manual(values=get_palette("npg",2)) +
    scale_color_manual(values=get_palette("npg",2)) +
    ylab('log(mapping percentage)') +
    theme_bw() +
    theme(axis.title.x=element_blank(),
          axis.title=element_text(size=18),
          axis.text=element_text(size=10,color="black"),
          #panel.border = element_blank(), 
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), 
          panel.border = element_blank(),
          axis.line = element_line(colour = "black"),
          legend.position='none',
          strip.background =element_rect(fill="white"),
          strip.text = element_text(size=18)) +
    scale_x_discrete(labels=c("Darwin's finches",'Related tanagers')) +
    geom_text(data=ann_text[1,],aes(x,y,label=lab),color='black',size=5.5)

png('fig_outgroup.png',height=7,width=7,units='in',res=300)
map
dev.off()


