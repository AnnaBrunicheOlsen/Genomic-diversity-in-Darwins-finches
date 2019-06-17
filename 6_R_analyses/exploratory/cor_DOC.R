#Hierarchical analysis of heterozygosity/ROHs in Darwin's finches

suppressMessages(library(rstan))

source('clean_data.R')

#------------------------------------------------------------------------------
# Format data for Stan

run = "8x"
raw_data <- read_data(paste(run,'_DF',sep=''))
inp_data <- list(
  n_groups = n_distinct(raw_data$species_group),
  n_grp_params = 1, #intercept (diet?)
  X_grp = as.matrix(rep(1, n_distinct(raw_data$species_group))),
  n_species = n_distinct(raw_data$species),
  n_sp_params = 1, # red list status, diet
  X_sp = as.matrix(species_info[,c('Red_list')]),
  n_obs = nrow(raw_data),
  n_ind_params = 2, 
  X_ind = as.matrix(raw_data[,c('Area_z','Mass_z')]),
  group = as.numeric(as.factor(species_info$species_group)),
  species = as.numeric(as.factor(raw_data$species))
)

ch <- cor.test(log(raw_data$heteroAll), log(raw_data$depth_of_coverage))
cf <- cor.test(log(raw_data$Froh), log(raw_data$depth_of_coverage))

library(ggplot2)
library(gridExtra)
library(ggpubr)

colvals <- get_palette('npg',2)

ch_plot <- raw_data %>%
  ggplot(aes(x=depth_of_coverage,y=log(heteroAll))) +
  geom_point(col=colvals[1]) +
  ylab(expression(log(italic(H)))) +
  xlab('log(Depth of coverage)') +
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
  annotate("text",30,-5.4,label='italic(r) == -0.18',size=5, parse=T) +
  annotate("text",30,-5.7,label='italic(p) == 0.01',size=5, parse=T) +
  annotate("text",5, -5, label='a)',size=5)


fr_plot <- raw_data %>%
  ggplot(aes(x=depth_of_coverage,y=log(Froh))) +
  geom_point(col=colvals[2]) +
  ylab(expression(log(italic(F)[ROH]))) +
  xlab('log(Depth of coverage)') +
  geom_smooth(method='lm',se=F,col=colvals[2]) +
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
  annotate("text",30,-3,label='italic(r) == 0.13',size=5, parse=T) +
  annotate("text",30,-3.5,label='italic(p) == 0.07',size=5, parse=T) +
  annotate("text",5, 0, label='b)',size=5)

tiff('fig_S8.tiff',height=5,width=7,units='in',res=300,compression='lzw')
grid.arrange(ch_plot, fr_plot, ncol=2)
dev.off()
