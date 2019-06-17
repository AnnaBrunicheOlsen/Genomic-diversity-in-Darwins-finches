library(tidyverse)
library(readxl)

neb <- read_excel('Neb.xlsx') %>%
  arrange(population)
dat <- read_excel('heterozygosity_plink_29112018.xlsx',sheet='DF_info') %>%
  select(Island,species,island_area_km2) %>%
  group_by(Island,species,island_area_km2) %>%
  summarize() %>%
  arrange(species,Island)

area_neb <- as_tibble(data.frame(neb,dat)) %>%
  filter(Neb!='Infinite') %>%
  mutate(Neb=as.numeric(Neb))

area_neb %>% ggplot(aes(x=Neb,y=island_area_km2)) +
  geom_point()

cor.test(area_neb$Neb,area_neb$island_area_km2)

