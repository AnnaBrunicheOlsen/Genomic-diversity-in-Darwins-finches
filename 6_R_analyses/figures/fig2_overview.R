setwd('..')
source('clean_data.R')
library(ggpubr)
library(gridExtra)

run = "8x"
raw_data <- read_data(paste(run,'_DF',sep='')) %>%
  mutate(Red_list = ifelse(Red_list=="endangered",1,0))

setwd('figures')

fig_data <- raw_data %>%
  left_join(phylo_info %>% select(Individual,taxa_group),
            by="Individual") %>%
  select(Individual,species,taxa_group,rohNumber,rohLength,heteroAll,Froh,
         species_group,Mass,Area) %>%
  mutate(taxa_group = as.character(taxa_group)) %>%
  mutate(taxa_group = case_when(taxa_group == 'Camarhynchus_pallidus_SC' ~ 'Camarhynchus_pallidus_SZ',
                                taxa_group == 'Camarhynchus_parvulus_SC' ~ 'Camarhynchus_parvulus_SZ',
                                taxa_group == 'Certhidea_fusca_S' ~ 'Certhidea_fusca_SC',
                                taxa_group == 'Geospiza_magnirostris_D' ~ 'Geospiza_magnirostris_DM',
                                taxa_group == 'Geospiza_fortis_SC' ~ 'Geospiza_fortis_SZ',
                                taxa_group == 'Geospiza_fuliginosa_SC' ~ 'Geospiza_fuliginosa_SZ',
                                TRUE ~ taxa_group)) %>%
  mutate(Lroh = rohLength/1000, Nroh = rohNumber/1000) %>%
  rename(Population = taxa_group, Species = species) %>%
  mutate(Population = as.character(Population)) %>%
  mutate(Population = case_when(Species == 'Tiaris_bicolor' ~ 'Tiaris_bicolor',
                                Species == 'Loxigilla_noctis' ~ 'Loxigilla_noctis',
                                TRUE ~ Population))

froh <- fig_data %>%
  mutate(Population = str_replace_all(Population,"_"," ")) %>%
  mutate(Species = str_replace(Species,"_"," ")) %>%
  mutate(Population = factor(Population),
         Population = factor(Population,levels=rev(levels(Population)))) %>%
  ggplot(aes(x=Population,y=Froh,fill=Species,color=Species)) +
    geom_boxplot(alpha=0.6) +
    scale_fill_manual(values=get_palette("npg",17)) +
    scale_color_manual(values=get_palette("npg",17)) +
    coord_flip() +
    ylab(expression(italic(F)[ROH])) +
    theme_bw() +
    theme(axis.title = element_text(size=14),
          axis.text = element_text(size=10),
          axis.title.x = element_text(margin=margin(b=3,t=3)),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.border = element_blank(),
          axis.text.y = element_blank(),
          axis.title.y = element_blank(),
          axis.ticks.y = element_blank(),
          axis.line = element_line(colour = "black"),
          legend.position="none",
          legend.title = element_text(size=14)) +
  annotate("text",27,0.6,label="d)",size=6)


het <- fig_data %>%
  mutate(Population = str_replace_all(Population,"_"," ")) %>%
  mutate(Species = str_replace(Species,"_"," ")) %>%
  mutate(Population = factor(Population),
         Population = factor(Population,levels=rev(levels(Population)))) %>%
  ggplot(aes(x=Population,y=heteroAll,fill=Species,col=Species)) +
    geom_boxplot(alpha=0.6) +
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
          legend.title = element_text(size=14)) +
  annotate("text",27,0.005,label="c)",size=6)

size <- fig_data %>%
  mutate(Population = str_replace_all(Population,"_"," ")) %>%
  mutate(Species = str_replace(Species,"_"," ")) %>%
  mutate(Population = factor(Population),
         Population = factor(Population,levels=rev(levels(Population)))) %>%
  ggplot(aes(x=Population,y=Mass,fill=Species,col=Species)) +
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
  mutate(Population = str_replace_all(Population,"_"," ")) %>%
  mutate(Species = str_replace(Species,"_"," ")) %>%
  mutate(Population = factor(Population),
         Population = factor(Population,levels=rev(levels(Population)))) %>%
  ggplot(aes(x=Population,y=Area,fill=Species,col=Species)) +
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

png('fig2_overview.png',height=7,width=10,units='in',res=300)
grid.arrange(size,area,het,froh,ncol=4,widths=c(1.9,1,1,1))
dev.off()
