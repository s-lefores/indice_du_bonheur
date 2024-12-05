merge_csv_files <- function() {

raw_folder <- here::here("data")


raw_data_1 <- read.csv(file.path(raw_folder, "Data_Insee.csv"), header = TRUE, sep=";") 
raw_data_2 <- read.csv(file.path(raw_folder, "Donnee_altitude_mer.csv"), header = TRUE, sep=";") 
raw_data_3 <- read.csv(file.path(raw_folder, "donnee-delinquance.csv"), header = TRUE, sep=";") 
raw_data_4 <- read.csv(file.path(raw_folder, "resultats-election.csv"), header = TRUE, sep=";") 
raw_data_5 <- read.csv(file.path(raw_folder, "temps-densoleillement-par-an-par-departement.csv"), header = TRUE, sep=";")

cle_code_dep <- raw_data_1 %>%
  select(Code, Departement)

raw_data_5_bis <- raw_data_5 %>%
  left_join(cle_code_dep, by = "Departement") %>% 
  mutate(
    Code = case_when(
      Departement == "Côte-d’Or" ~ "21",
      Departement == "Côtes d'Armor" ~ "22",
      Departement == "Eure-et-Loire" ~ "28",
      Departement == "Territoire-de-Belfort" ~ "90",
      Departement == "Alpes de Haute Provence" ~ "4",
      TRUE ~ Code  
    )
  )

merged_data <- raw_data_1 %>%
  full_join(raw_data_2) %>%
  full_join(raw_data_3) %>%
  full_join(raw_data_4) %>%
  full_join(raw_data_5_bis)
  
  return(merged_data)
}


