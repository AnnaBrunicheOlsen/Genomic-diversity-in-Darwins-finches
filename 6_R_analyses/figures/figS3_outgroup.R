setwd('..')
source('clean_data.R')

#------------------------------------------------------------------------------
# Format for Stan

run = "8x"
raw_data <- read_data(paste(run,'_DF',sep=''))

raw_data <- raw_data %>%
  mutate(is_outgroup = case_when(
            species %in% c('Tiaris_bicolor','Loxigilla_noctis') ~ 'Outgroup',
            TRUE ~ 'Ingroup'))

setwd('figures')

pvals <- c(
t.test(log(heteroAll) ~ is_outgroup, data=raw_data)$p.value,
t.test(log(Froh+0.05) ~ is_outgroup, data=raw_data)$p.value)

library(ggplot2)
library(ggpubr)
library(gridExtra)
plot_data <- raw_data %>%
  mutate(Froh = log(Froh+0.05),
         heteroAll = log(heteroAll)) %>%
  gather(key='prm',value='val',heteroAll,Froh) %>%
  mutate(prm = recode(prm, "heteroAll" = "H", "Froh" = "F[ROH]",
                      "rohNumber"="N[ROH]" ),
         prm = factor(prm,levels=c("H","F[ROH]"))) %>%
  select(prm,val,is_outgroup) 

ann_text <- data.frame(x=1.5,y=c(-4,0),
                       lab=paste('P =',sprintf("%.2f",round(pvals,2))),
                       prm=c("H","F[ROH]"),
                       is_outgroup="Ingroup")

het <- plot_data %>%
  filter(prm=='H') %>%
ggplot(aes(x = is_outgroup, y = val, fill=is_outgroup,color=is_outgroup)) +
  geom_boxplot(alpha=0.6) +
  scale_fill_manual(values=get_palette("npg",2)) +
  scale_color_manual(values=get_palette("npg",2)) +
  ylab('log(H)') +
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
  geom_text(data=ann_text[1,],aes(x,y,label=lab),color='black',size=5.5) +
  annotate("text",0.7,-4,label='a)',size=6)

froh <- plot_data %>%
  filter(prm=='F[ROH]') %>%
  ggplot(aes(x = is_outgroup, y = val, fill=is_outgroup,color=is_outgroup)) +
  geom_boxplot(alpha=0.6) +
  scale_fill_manual(values=get_palette("npg",2)) +
  scale_color_manual(values=get_palette("npg",2)) +
  ylab(expression(log(F[ROH]))) +
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
  geom_text(data=ann_text[2,],aes(x,y,label=lab),color='black',size=5.5) +
  annotate("text",0.7,0,label='b)',size=6)

png('figS3_outgroup.png',height=7,width=7,units='in',res=300)
grid.arrange(het,froh,ncol=2)
dev.off()


