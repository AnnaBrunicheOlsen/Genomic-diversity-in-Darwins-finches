suppressMessages(library(rstan))
suppressMessages(library(tidyverse))
suppressMessages(library(ggplot2))
suppressMessages(library(ggpubr))

#Load dataset
load('../output/out_8x.Rdata')

#Helper function
simplify_table <- function(x,response){
  raw_tab <- summary(x)$summary[1:7,c(1,4,8)]
  row.names(raw_tab) <- c('Intercept','SD_group','Red list','SD_species','Island area',
                          'Mass','SD_individual')
  raw_tab %>%
    as.data.frame() %>%
    rownames_to_column() %>%
    rename(Parameter = rowname) %>%
    mutate(Response = response)
}

xind <- c(1:6)

fig_data <- simplify_table(finch_out_het,"Heterozygosity")
fig_data <- rbind(fig_data,simplify_table(finch_out_FROH,"FROH"))
fig_data_mod <- fig_data%>%
  mutate(Response = factor(Response,levels=c("Heterozygosity",
                                               "FROH","NROH"))) %>%
  filter(Parameter %in% c('Red list','Island area','Mass')) %>%
  mutate(Parameter = factor(Parameter, levels=c('Red list','Island area','Mass')),
           Parameter = fct_recode(Parameter, `Red list status` = "Red list",
                                  `Body mass` = 'Mass')) %>%
  rename(`Effect Size` = mean)

fig_data_mod <- fig_data_mod[c(2,5,3,6,1,4),]

out <- fig_data_mod %>%
  ggplot(aes(x=xind,y=`Effect Size`,group=1,color=Response)) +
  scale_color_manual(values=get_palette('npg',2)) +
  geom_point(size=4) +
  geom_errorbar(aes(x=xind,ymin=`2.5%`,ymax=`97.5%`),width=0.2,
                  size=1) +
  geom_hline(yintercept=0,linetype=2) +
  scale_x_continuous(breaks=xind,labels=rep(c("Heterozygosity" = expression(italic(H)), 
                              "FROH" = expression(italic(F)[ROH])),3)) +
  ylab('Effect Size ± 95% CI') +
  geom_vline(xintercept=2.5) +
  geom_vline(xintercept=4.5) +
  theme_bw() +
  theme(axis.title.x=element_blank(),
          axis.title=element_text(size=18),
          axis.text=element_text(size=18,color="black"),
          #panel.border = element_blank(), 
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), 
          axis.line = element_line(colour = "black"),
          legend.position='none',
          strip.background =element_rect(fill="white"),
          strip.text = element_text(size=18)) +
  annotate("text",1.4,1.8,label="a) Island area",size=6) +
  annotate("text",3.2,1.8,label="b) Body size",size=6) +
  annotate("text",5.4,1.8,label="c) Red list status",size=6)

#Generate figures
ggsave('fig3_effectsize.png', width=7,height=7)
