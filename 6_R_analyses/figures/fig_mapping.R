library(tidyverse)
library(readxl)
library(ggpubr)
library(gridExtra)

raw_data <- read_excel('../data/DarwinsFinches_22082019.xlsx') %>%
  mutate(is_fortis = ifelse(Species!="Geospiza_fortis","Other species",
                            "Geospiza fortis")) %>%
  rename(het = Heterozygosity_SFS)

pval_map <- wilcox.test(mapping_percentage ~ is_fortis, data=raw_data)$p.value
pval_h <- wilcox.test(het ~ is_fortis, data=raw_data)$p.value
pval_F <- wilcox.test(Fu_Li_F ~ is_fortis, data=raw_data)$p.value
pval_theta <- wilcox.test(WattersonsThetaMean ~ is_fortis, data=raw_data)$p.value

pval <- c(pval_map, pval_h, pval_F, pval_theta)

fig_data <- raw_data %>%
  gather(key='Parameter', value='value', mapping_percentage,het,Fu_Li_F,
         WattersonsThetaMean) %>%
  select(Individual, Parameter, value, is_fortis) %>%
  mutate(Parameter = factor(Parameter),
         Parameter = fct_recode(Parameter, "Mapping percentage"="mapping_percentage",
                                "Fu-Li F"="Fu_Li_F","Heterozygosity"="het",
                                "Watterson's Theta"="WattersonsThetaMean"),
         Parameter = factor(Parameter, levels=c("Mapping percentage","Heterozygosity",
                                                "Fu-Li F", "Watterson's Theta")))

ann_text <- data.frame(x=1.5,y=c(99.5,0.0057,1.09,260),
                       lab=paste('P =',sprintf("%.2f",round(pval,2))),
                       Parameter=c("Mapping percentage","Heterozygosity",
                                   "Fu-Li F", "Watterson's Theta"),
                       is_fortis="Other species")
ann_text$lab <- as.character(ann_text$lab)
ann_text$lab[ann_text$lab=="P = 0.00"] <- "P < 0.01"


fig_data %>%
  ggplot(aes(x = is_fortis, y = value, 
             fill=is_fortis,color=is_fortis)) +
    geom_boxplot(alpha=0.6) +
    scale_fill_manual(values=get_palette("npg",2)) +
    scale_color_manual(values=get_palette("npg",2)) +
    ylab('Parameter value') +
    facet_wrap(~Parameter,scales='free') +
    theme_bw() +
    theme(axis.title.x=element_blank(),
          axis.title=element_text(size=18),
          axis.text=element_text(size=10,color="black"),
          axis.text.x=element_text(size=12),
          #panel.border = element_blank(), 
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), 
          panel.border = element_blank(),
          axis.line = element_line(colour = "black"),
          legend.position='none',
          strip.background =element_rect(fill="white"),
          strip.text = element_text(size=16)) +
    #scale_x_discrete(labels=c("",'Related tanagers')) +
    geom_text(data=ann_text,aes(x,y,label=lab),color='black',size=5.5)

ggsave('fig_mapping.png',height=7,width=7)


## Correlations between mapping and other vars

my_theme = theme(axis.title=element_text(size=18),
          axis.text=element_text(size=14,color="black"),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), 
          legend.position='none')

#Calculate spearman correlation p values
hp <- cor.test(raw_data$mapping_percentage, 
               raw_data$het, method='spearman')
hp <- c(hp$estimate,hp$p.val)

fp <- cor.test(raw_data$mapping_percentage, 
               raw_data$Fu_Li_F, method='spearman')
fp <- c(fp$estimate,fp$p.val)

wp <- cor.test(raw_data$mapping_percentage,
               raw_data$WattersonsThetaMean, method='spearman')
wp <- c(wp$estimate,wp$p.val)

stats <- rbind(hp,fp,wp)

pvals <- paste0('rho = ',sprintf("%.3f",round(stats[,1],3)),';',
               '  P =',sprintf("%.2f",round(stats[,2],2)))

hetplot <- raw_data %>%
  ggplot(aes(x=mapping_percentage,y=het)) +
  geom_point(col=get_palette("npg",1)) +
  theme_bw() +
  my_theme +
  xlab("Mapping percentage") +
  ylab("Heterozygosity") +
  annotate(x = mean(range(raw_data$mapping_percentage)),
           y = max(raw_data$het), "text", label=pvals[1],size=5)

fuplot <- raw_data %>%
  ggplot(aes(x=mapping_percentage,y=Fu_Li_F)) +
  geom_point(col=get_palette("npg",1)) +
  theme_bw() +
  my_theme +
  xlab("Mapping percentage") +
  ylab("Fu-Li F") +
  annotate(x = mean(range(raw_data$mapping_percentage)),
           y = max(raw_data$Fu_Li_F)*1.2, "text", label=pvals[2],size=5)

watplot <- raw_data %>%
  ggplot(aes(x=mapping_percentage,y=WattersonsThetaMean)) +
  geom_point(col=get_palette("npg",1)) +
  theme_bw() +
  my_theme +
  xlab("Mapping percentage") +
  ylab("Watterson's theta") +
  annotate(x = mean(range(raw_data$mapping_percentage)),
           y = max(raw_data$WattersonsThetaMean), "text", label=pvals[3],size=5)

png("figure_mapping_cors.png", height=7, width=7, units="in", res=300)
grid.arrange(hetplot, fuplot, watplot, nrow=2)
dev.off()
