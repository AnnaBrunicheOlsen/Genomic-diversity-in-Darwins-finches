suppressMessages(library(rstan))
suppressMessages(library(tidyverse))
suppressMessages(library(ggplot2))
suppressMessages(library(ggpubr))

#Helper function
simplify_table <- function(x,coverage){
  raw_tab <- summary(x)$summary[1:7,c(1,4,8)]
  row.names(raw_tab) <- c('Intercept','SD_group','Red list','SD_species','Island area',
                          'Mass','SD_individual')
  raw_tab %>%
    as.data.frame() %>%
    rownames_to_column() %>%
    rename(Parameter = rowname) %>%
    mutate(Coverage = coverage)
}

#Figure function
gen_fig <- function(object, title){

  coverages <- c('16x','12x','8x','4x')
  outputs <- paste('../output/out_',coverages,'.Rdata',sep='')

  get_obj <- function(){
    eval(parse(text=object))
  }

  load(outputs[1])
  fig_data <- simplify_table(get_obj(),coverages[1])

  for (i in 2:4){
    load(outputs[i])
    fig_data <- rbind(fig_data, simplify_table(get_obj(),coverages[i]))
  }

  fig_data%>%
    mutate(Coverage = factor(Coverage,levels=c('4x','8x','12x','16x'))) %>%
    filter(Parameter != 'Intercept') %>%
    rename(`Effect Size` = mean) %>%
    ggplot(aes(x=Coverage,y=`Effect Size`,group=1,color=Parameter)) +
    geom_line() +
    scale_color_manual(values=get_palette('npg',10)) +
    geom_point() +
    geom_errorbar(aes(x=Coverage,ymin=`2.5%`,ymax=`97.5%`),width=0.1) +
    geom_hline(yintercept=0,linetype=2) +
    facet_wrap(~Parameter,scales='free') +
    #ggtitle(title) +
    ylab('Effect Size ± 95% CI') +
    theme(plot.title = element_text(hjust = 0.5),
          legend.position='none')
}

#Generate figures
het <- gen_fig('finch_out_het','Heterozygosity')
ggsave('fig_het.png')

nroh <- gen_fig('finch_out_NROH','NROH')
ggsave('fig_NROH.png')

froh <- gen_fig('finch_out_FROH','FROH')
ggsave('fig_FROH.png')
