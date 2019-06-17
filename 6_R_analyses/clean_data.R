#------------------------------------------------------------------------------
# Load required packages
suppressMessages(library(tidyverse))
suppressMessages(library(readxl))
suppressMessages(library(ape))
#------------------------------------------------------------------------------
# Source datasets
datafile <- 'data/heterozygosity_plink_29112018.xlsx'
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Read and clean up sample info
sample_info <- read_excel(datafile, sheet='DF_info') %>%
  mutate(Island = case_when(str_detect(Island,'pinta*') ~ 'Pinta',
                            TRUE ~ Island),
         Area = str_replace(island_area_km2,',','.'),
         Area = str_replace(Area, 'pinta_18_marchena_130', '18'),
         Area = as.numeric(Area),
         Mass = as.numeric(weight_gram),
         Red_list = ifelse(Red_list == 'least_concern','least_concern',
                           'endangered')) %>%
  select(Individual,species_group,species,Island,Area,Red_list,diet,Mass,Ne,
  depth_of_coverage)

species_info <- sample_info %>%
  group_by(species, Red_list, species_group) %>%
  summarize() %>%
  arrange(species) %>%
  ungroup() %>%
  mutate(Red_list = ifelse(Red_list == 'endangered', 1, 0))

#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Read and clean up genetic data
read_data <- function(sheet){
  read_excel(datafile, sheet=sheet) %>%
    rename_all(~sub('rohLenght','rohLength',.x)) %>%
    rename(Individual = PWD) %>%
    #filter(! species %in% c('Tiaris_bicolor', 'Loxigilla_noctis')) %>%
    mutate(het_snp = het/SNPs) %>%
    select(Individual,rohNumber,rohLength,heteroAll,Froh,het_snp) %>%
    left_join(sample_info, by='Individual') %>%
    mutate(Area_z = as.numeric(scale(Area)),
           Mass_z = as.numeric(scale(Mass)),
           Ne_z = as.numeric(scale(Ne)),
           Fruit = ifelse(diet == 'fruit', 1, 0),
           Seeds = ifelse(diet == 'seeds', 1, 0))
}
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Read and clean up phylo data
tree = read.tree('data/Lamichhaney_Science_2016.newick')

#Match species to tree tips
phylo_info <- read_excel(datafile, sheet='DF_info') %>%
  mutate(taxa_group =
  case_when(
    species=='Certhidea_fusca'&Island=='Espanola' ~ 'Certhidea_fusca_E',
    species=='Certhidea_fusca'&Island=='San_Cristobal' ~ 'Certhidea_fusca_S',
    species=='Certhidea_olivacea' ~ 'Certhidea_olivacea',
    species=='Geospiza_conirostris'&Island=='Genovesa' ~ 'Geospiza_conirostris_G',
    species=='Geospiza_conirostris'&Island=='Espanola' ~ 'Geospiza_conirostris_E',
    species=='Geospiza_fortis'&Island=='Daphne' ~ 'Geospiza_fortis_DM',
    species=='Geospiza_fortis' ~ 'Geospiza_fortis_SC',
    species=='Geospiza_difficilis'&Island=='Darwin' ~ 'Geospiza_difficilis_D',
    species=='Geospiza_difficilis'&Island=='Fernandina' ~ 'Geospiza_difficilis_F',
    species=='Geospiza_difficilis'&Island=='Genovesa' ~ 'Geospiza_difficilis_G',
    species=='Geospiza_difficilis'&Island=='Pinta' ~ 'Geospiza_difficilis_P',
    species=='Geospiza_difficilis'&Island=='Santiago' ~ 'Geospiza_difficilis_S',
    species=='Geospiza_difficilis'&Island=='Wolf' ~ 'Geospiza_difficilis_W',
    species=='Geospiza_fuliginosa'&Island=='Santa_Cruz' ~ 'Geospiza_fuliginosa_SC',
    species=='Geospiza_fuliginosa'&Island=='Santiago' ~ 'Geospiza_fuliginosa_S',
    species=='Geospiza_magnirostris'&Island=='Daphne' ~ 'Geospiza_magnirostris_D',
    species=='Geospiza_magnirostris'&Island=='Genovesa' ~ 'Geospiza_magnirostris_G',
    species=='Tiaris_bicolor' ~ 'Outgroups',
    species=='Loxigilla_noctis' ~ 'Outgroups',
    TRUE ~ species),
    taxa_group = factor(taxa_group,levels=sort(unique(taxa_group))))

#Format vcov matrix
keep = tree$tip.label %in% levels(phylo_info$taxa_group)
cormat <- vcv(tree,corr=T)[keep,keep]
rearrange <- order(colnames(cormat))
cormat <- cormat[rearrange,rearrange]
indmat <- diag(nrow(cormat)) 


pop_info <- phylo_info %>%
  group_by(taxa_group, species) %>% summarize() %>%
  filter(species != 'Tiaris_bicolor')

species_codes <- as.numeric(as.factor(pop_info$species))

pop_codes <- as.numeric(phylo_info$taxa_group)
#------------------------------------------------------------------------------


