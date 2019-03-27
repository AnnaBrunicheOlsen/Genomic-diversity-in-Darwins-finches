suppressMessages(library(rstan))

source('clean_data.R')

#------------------------------------------------------------------------------
# Format for Stan

run = "8x"
raw_data <- read_data(paste(run,'_DF',sep='')) %>%
  mutate(Red_list = ifelse(Red_list=="endangered",1,0))

inp_data <- list(
  #n_groups = n_distinct(raw_data$species_group),
  #n_grp_params = 1, #intercept (diet?)
  #X_grp = as.matrix(rep(1, n_distinct(raw_data$species_group))),
  #n_species = n_distinct(raw_data$species),
  #n_sp_params = 1, # red list status, diet
  #X_sp = as.matrix(species_info[,c('Red_list')]),
  n_obs = nrow(raw_data),
  n_ind_params = 4, 
  X_ind = as.matrix(cbind(1,raw_data[,c('Red_list','Area_z','Mass_z')])),
  #group = as.numeric(as.factor(species_info$species_group)),
  #species = species_codes,
  n_pops = max(pop_codes),
  pop = pop_codes,
  cormat = cormat,
  indmat = indmat
)

model_file = 'model_rohs_phylo.stan'
#pars = c('beta_grp','sd_grp','beta_sp','sd_sp','beta_pop','sd_pop',
#         'sd_ind','lambda')
pars = c('beta_ind','sd_pop','sd_ind','lambda')
outname = paste('out_',run,'_phylo.Rdata',sep='')

#====Run Stan==================================================================
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

#inits = function(){
#  list(var_grp = runif(1,0,1),
#       var_sp = runif(1,0,1),
#      var_ind = runif(1,0,1),
#       var_pop = runif(1,0,1))
#}
inits <- function(){
  list(var_pop = runif(1,0,1),
       var_ind = runif(1,0,1))
}

#Heterozygosity
inp_data$y = log(raw_data$heteroAll)
finch_out_het = stan(
      model_code = readChar(model_file, file.info(model_file)$size),
			data = inp_data, 
			pars = pars,
      init = inits,
			chains = 3, iter = 4000, warmup = 3800, thin = 2,
      control = list(adapt_delta=0.99))

#Number ROHs
inp_data$y = log(raw_data$rohNumber + 0.5)
finch_out_NROH = stan(
      model_code = readChar(model_file, file.info(model_file)$size),
			data = inp_data, 
			pars = pars,
      chains = 3, iter = 2000, warmup = 1800, thin = 1,
      control = list(adapt_delta=0.99))

#Froh
inp_data$y = log(raw_data$Froh + 0.05)
finch_out_FROH = stan(
      model_code = readChar(model_file, file.info(model_file)$size),
			data = inp_data, 
			pars = pars,
      chains = 3, iter = 2000, warmup = 1800, thin = 1,
      control = list(adapt_delta=0.99))

save(finch_out_het,finch_out_NROH,finch_out_FROH,
     file=outname)
