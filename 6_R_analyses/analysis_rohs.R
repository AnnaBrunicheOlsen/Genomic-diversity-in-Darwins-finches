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

model_file = 'model_rohs.stan'
pars = c('beta_grp','sd_grp','beta_sp','sd_sp','beta_ind','sd_ind')
outname = paste('output/out_',run,'.Rdata',sep='')

#------------------------------------------------------------------------------

#====Run Stan==================================================================
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

#Heterozygosity
#inp_data$y = log(raw_data$heteroAll)
inp_data$y = log(raw_data$het_snp)
finch_out_het = stan(
      model_code = readChar(model_file, file.info(model_file)$size),
			data = inp_data, 
			pars = pars,
			chains = 3, iter = 2000, warmup = 1800, thin = 1,
      control = list(adapt_delta=0.99))

#Froh
#inp_data$y = log(raw_data$Froh + 0.05)
#finch_out_FROH = stan(
#      model_code = readChar(model_file, file.info(model_file)$size),
#			data = inp_data, 
#			pars = pars,
#      chains = 3, iter = 2000, warmup = 1800, thin = 1,
#      control = list(adapt_delta=0.99))

save(finch_out_het,#finch_out_FROH,
     file=outname)

#------------------------------------------------------------------------------

library(lme4)
library(lmerTest)

raw_data$Red_list_bin <- ifelse(raw_data$Red_list=='least_concern',0,1)
mod <- lmer(log(heteroAll) ~ Area_z + Mass_z + Red_list_bin 
            + (1|species) + (1|species_group), 
            data=raw_data)
summary(mod)

mod_alt <- lmer(log(het_snp) ~ Area_z + Mass_z + Red_list_bin 
            + (1|species) + (1|species_group), 
            data=raw_data)
summary(mod_alt)

mod <- lmer(log(heteroAll) ~ Area_z + Mass_z + Red_list_bin + (1|species),
            data=raw_data)
summary(mod)

mod_froh <- lmer(log(Froh+0.05) ~ Area_z + Mass_z + Red_list_bin 
            + (1|species) + (1|species_group), 
            data=raw_data)

summary(mod_froh)
