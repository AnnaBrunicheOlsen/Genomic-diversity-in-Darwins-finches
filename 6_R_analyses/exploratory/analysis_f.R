library(tidyverse)
library(readxl)
#library(weights)

theta <- read_excel('../data/heterozygosity_plink_12062019.xlsx',
                 sheet='wattersonsTheta') %>%
        arrange(population)
theta <- theta[1:27,]

all_info <- read_excel('../data/heterozygosity_plink_12062019.xlsx',
                 sheet='DF_info') %>%
        mutate(population=paste0(species,'_',Island)) %>%
        group_by(population, weight_gram, Fu_Li_F, island_area_km2,
                 Red_list_two) %>%
        summarize() %>%
        ungroup() %>%
        mutate(Red_list_two = ifelse(Red_list_two=='treatened','Threatened',
                                     'Non-threatened')) 

theta <- cbind(theta,all_info[-6,])

t.test(Fu_Li_F ~ Red_list_two, data=theta)

library(ggpubr)
tiff('fig_F_vs_Redlist.tiff', height=7, width=5, units='in', res=300,
     compression='lzw')
theta[,-1] %>%
  ggplot(aes(x=Red_list_two, y=Fu_Li_F, fill=Red_list_two,
             color=Red_list_two)) +
  geom_boxplot(alpha=0.6) +
  scale_fill_manual(values=get_palette('npg',2)) +
  scale_color_manual(values=get_palette('npg',2)) +
  ylab(expression("Fu's"~italic(F[s]))) +
  xlab('Red List status') +
  theme_bw() +
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
  #annotate('text', 1.5, 1.1, label='italic(t) == -1.29',size=5,parse=T) +
  annotate('text', 1.5,-0.8, label='P = 0.21',size=5)
dev.off()

####old

f_data <- read_csv('data/f_14122028.csv') %>%
  unite(pop, c('species.x','Island')) %>%
  group_by(pop, Red_list_two.x, F, Fu_Li_F) %>%
  summarize() %>%
  mutate(Fcat = ifelse(F=='decline',1,0))

test <- glm(Fcat ~ Red_list_two.x, family='binomial',data=f_data)
summary(test)

table(f_data$Red_list_two.x,f_data$F)

library(logistf)


test <- logistf(Fcat ~ Red_list_two.x, data=f_data)
summary(test)


con_test <- lm(Fu_Li_F ~ Red_list_two.x, data=f_data)
summary(con_test)
