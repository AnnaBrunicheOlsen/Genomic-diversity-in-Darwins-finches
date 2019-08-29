library(tidyverse)
library(readxl)
library(ggpubr)
library(gridExtra)

raw_data <- read_excel('../data/DarwinsFinches_22082019.xlsx')

fig_data <- raw_data %>%
  rename(het = Heterozygosity_SFS) %>%
  mutate(pop_status = ifelse(Fu_Li_F > 0, "decline", "expansion"))

pval <- t.test(log(het) ~ pop_status, data=fig_data)$p.val
pval <- "P < 0.01"

out <- fig_data %>%
  ggplot(aes(x=pop_status, y=log(het))) +
  geom_boxplot(aes(col=pop_status,fill=pop_status),alpha=0.6) +
  scale_color_manual(values=get_palette('npg',2)) +
  scale_fill_manual(values=get_palette('npg',2)) +
  theme_bw() +
  ylab(expression(log(italic(H)))) +
  theme(axis.title = element_text(size=14),
        axis.text = element_text(size=12),
        axis.text.x = element_text(size=14),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title.x = element_blank(),
        legend.position="none",
        legend.title = element_text(size=14)) +
  annotate(x=1.5, y=-5,"text", label=pval, size=5)

ggsave('fig4_HvsDecline.png', height=7, width=5)
