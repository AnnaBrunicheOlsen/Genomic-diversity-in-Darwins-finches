setwd('..')
source('clean_data.R')

run <- paste0(c(4,8,12,16),'x')

raw_data <- read_data(paste0(run[1],'_DF'))
raw_data$coverage <- '4x'

for (i in 2:4){
  
  add <- read_data(paste0(run[i],'_DF'))
  add$coverage <- run[i]
  raw_data <- raw_data %>%
    bind_rows(add)

}

raw_data <- raw_data %>%
  mutate(coverage=factor(coverage,levels=c('4x','8x','12x','16x')))

library(ggplot2)
library(ggpubr)
library(gridExtra)

hplot <- raw_data %>%
  ggplot(aes(x=coverage,y=log(heteroAll),fill=coverage)) +
  geom_boxplot() +
  scale_fill_manual(values=get_palette('npg',4)) +
  theme_bw() +
  ylab(expression(log(italic(H)))) +
  xlab('Coverage') +
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        axis.title=element_text(size=14),
        axis.text=element_text(size=12),
        legend.position='none')

fplot <- raw_data %>%
  ggplot(aes(x=coverage,y=log(Froh+0.05),fill=coverage)) +
  geom_boxplot() +
  scale_fill_manual(values=get_palette('npg',4)) +
  theme_bw() +
  ylab(expression(F[ROH])) +
  xlab('Coverage') +
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        axis.title=element_text(size=14),
        axis.text=element_text(size=12),
        legend.position='none')

pdf('exploratory/fig_justify_coverage.pdf')
grid.arrange(hplot,fplot,ncol=2)
dev.off()
