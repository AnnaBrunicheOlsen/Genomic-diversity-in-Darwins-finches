//Hierarchical Finch Model

data {
  
  int<lower=0> n_groups;
  int<lower=0> n_grp_params;
  matrix[n_groups,n_grp_params] X_grp;

  int<lower=0> n_species;
  int<lower=0> n_sp_params;
  matrix[n_species,n_sp_params] X_sp;

  int<lower=0> n_obs;
  int<lower=0> n_ind_params;
  matrix[n_obs,n_ind_params] X_ind;

  int<lower=0> group[n_species];
  int<lower=0> species[n_obs];

  real y[n_obs];

}

parameters {

  vector[n_grp_params] beta_grp;
  real var_grp;
  vector[n_groups] grp_eff;

  vector[n_sp_params] beta_sp;
  real var_sp;
  vector[n_species] sp_eff;

  vector[n_ind_params] beta_ind;
  real var_ind;

}

transformed parameters {
  
  vector[n_groups] mu_grp;
  vector[n_species] mu_sp;
  vector[n_obs] mu_ind;

  real sd_grp;
  real sd_sp;
  real sd_ind;
  matrix[n_species,n_species] sigma_sp;
  
  sd_grp = sqrt(var_grp);
  sd_sp = sqrt(var_sp);
  sd_ind = sqrt(var_ind);

  mu_grp = X_grp * beta_grp; //intercept in X
  
  for (i in 1:n_species){
    mu_sp[i] = grp_eff[group[i]] + X_sp[i,] * beta_sp;
  }

  for (i in 1:n_obs){
    mu_ind[i] = sp_eff[species[i]] + X_ind[i,] * beta_ind;
  }

}

model {
  
  beta_grp ~ normal(0,1);
  var_grp ~ normal(0,1);
  grp_eff ~ normal(mu_grp, sd_grp);

  beta_sp ~ normal(0,1);
  var_sp ~ normal(0,1);
  sp_eff ~ normal(mu_sp, sd_sp);

  beta_ind ~ normal(0,1);
  var_ind ~ normal(0,1);
  y ~ normal(mu_ind, sd_ind);


}
