source('clean_data.R')
library(ggpubr)
library(gridExtra)

run = "8x"
raw_data <- read_data(paste(run,'_DF',sep='')) %>%
  mutate(Red_list = ifelse(Red_list=="endangered",1,0))

by_pop <- raw_data %>%
  group_by(species,Island,Mass,Area) %>%
  summarize(Hmean=mean(log(heteroAll)),
            Fmean=mean(Froh))

library(ggplot2)

pdf('comparison_within_species.pdf')

by_pop %>%
  ggplot(aes(x=Area,y=Hmean)) +
  geom_point() +
  geom_smooth(method='lm') +
  facet_wrap(~species) +
  ylab('log(H)') + xlab('Island area')

by_pop %>%
  ggplot(aes(x=Mass,y=Hmean)) +
  geom_point() +
  geom_smooth(method='lm',col='red') +
  facet_wrap(~species) +
  ylab('log(H)') + xlab('Body size')

by_pop %>%
  ggplot(aes(x=Area,y=Fmean)) +
  geom_point() +
  geom_smooth(method='lm') +
  facet_wrap(~species) +
  ylab('Froh') + xlab('Island area')

by_pop %>%
  ggplot(aes(x=Mass,y=Fmean)) +
  geom_point() +
  geom_smooth(method='lm',col='red') +
  facet_wrap(~species) +
  ylab('Froh') + xlab('Body size')

dev.off()