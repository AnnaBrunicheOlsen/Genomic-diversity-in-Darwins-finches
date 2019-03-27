//Hierarchical Finch Model

data {
  
  //int<lower=0> n_groups;
  //int<lower=0> n_grp_params;
  //matrix[n_groups,n_grp_params] X_grp;

  //int<lower=0> n_species;
  //int<lower=0> n_sp_params;
  //matrix[n_species,n_sp_params] X_sp;
  
  int<lower=0> n_pops;

  int<lower=0> n_obs;
  int<lower=0> n_ind_params;
  matrix[n_obs,n_ind_params] X_ind;

  //int<lower=0> group[n_species];
  //int<lower=0> species[n_pops];
  int<lower=0> pop[n_obs];
  matrix[n_pops,n_pops] cormat;
  matrix[n_pops,n_pops] indmat;

  real y[n_obs];

}

parameters {

  //vector[n_grp_params] beta_grp;
  //real var_grp;
  //vector[n_groups] grp_eff;

  //vector[n_sp_params] beta_sp;
  //real var_sp;
  //vector[n_species] sp_eff;

  real var_pop;
  vector[n_pops] pop_eff;

  vector[n_ind_params] beta_ind;
  real var_ind;

  real lambda;

}

transformed parameters {
  
  //vector[n_groups] mu_grp;
  //vector[n_species] mu_sp;
  //vector[n_pops] mu_pop;
  vector[n_obs] mu_ind;

  //real sd_grp;
  //real sd_sp;
  real sd_pop;
  real sd_ind;
  matrix[n_pops,n_pops] sigma_pop;
  
  //sd_grp = sqrt(var_grp);
  //sd_sp = sqrt(var_sp);
  sd_ind = sqrt(var_ind);
  sd_pop = sqrt(var_pop);

  sigma_pop = (lambda * cormat + (1 - lambda) * indmat) * sd_pop;

  //mu_grp = X_grp * beta_grp; //intercept in X
  
  //for (i in 1:n_species){
  //  mu_sp[i] = grp_eff[group[i]] + X_sp[i,] * beta_sp;
  //}

  //for (i in 1:n_pops){
  //  mu_pop[i] = sp_eff[species[i]];
  //}

  for (i in 1:n_obs){
    mu_ind[i] = X_ind[i,] * beta_ind + pop_eff[pop[i]]; 
  }

}

model {
  
  //beta_grp ~ normal(0,1);
  //var_grp ~ normal(0,1);
  //grp_eff ~ normal(mu_grp, sd_grp);

  //beta_sp ~ normal(0,1);
  //var_sp ~ normal(0,1);
  //sp_eff ~ normal(mu_sp, sd_sp);
  var_pop ~ normal(0,1);
  pop_eff ~ multi_normal(rep_vector(0,n_pops), sigma_pop);
  lambda ~ uniform(0,1);

  beta_ind ~ normal(0,1);
  var_ind ~ normal(0,1);
  y ~ normal(mu_ind, sd_ind);


}
