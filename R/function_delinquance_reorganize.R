library(dplyr)
library(tidyverse)
library(here)
delinquance_reorganize_function<-function() {
  data_delinquance <- read_delim(here::here("data","donnee-delinquance.csv"),
    delim = ";", escape_double = FALSE, trim_ws = TRUE
  )
  data_delinquance %>%
    rename(Code = Code.département) %>%
    mutate(tauxpourmille = as.numeric(str_replace_all(tauxpourmille, ",", "."))) %>%
    group_by(Code, classe) %>%
    summarise(pourcentage_pop = mean(tauxpourmille) / 10, unite = unique(unité.de.compte)) %>%
    mutate(classe = str_replace_all(classe, " ", "_")) %>%
    mutate(classe = paste("Nbre", unite, classe, sep = "_")) %>%
    select(Code, classe, pourcentage_pop) %>%
    pivot_wider(names_from = classe, values_from = pourcentage_pop) -> data_delinquance

  return(write.csv(data_delinquance, here::here("data","delinquance_reorganized.csv"), row.names = FALSE))
}
delinquance_reorganize_function()
