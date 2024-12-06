merge_csv_files <- function() {

cleaned_folder <- here::here("data","cleaned_data")


raw_data_1 <- read.csv(file.path(cleaned_folder, "Data_Insee.csv"), header = TRUE, sep=";") 
raw_data_2 <- read.csv(file.path(cleaned_folder, "Donnee_altitude_mer.csv"), header = TRUE, sep=";") 
raw_data_3 <- read.csv(file.path(cleaned_folder, "delinquance_reorganized.csv"), header = TRUE, sep=",") 
raw_data_4 <- read.csv(file.path(cleaned_folder, "data_election_reorganized.csv"), header = TRUE, sep=",") 
raw_data_5 <- read.csv(file.path(cleaned_folder, "temps-densoleillement-par-an-par-departement.csv"), header = TRUE, sep=";")

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
raw_data_3$Code[which(!is.na(as.numeric(raw_data_3$Code)))]<-
  as.character(as.numeric(raw_data_3$Code[which(!is.na(as.numeric(raw_data_3$Code)))]))
raw_data_4$Code[which(!is.na(as.numeric(raw_data_4$Code)))]<-
  as.character(as.numeric(raw_data_3$Code[which(!is.na(as.numeric(raw_data_4$Code)))]))
merged_data <- raw_data_1 %>%
  full_join(raw_data_2,by = "Code") %>%
  full_join(raw_data_3,by = "Code") %>%
  full_join(raw_data_4,by = "Code") %>%
  full_join(raw_data_5_bis,by = "Code")%>%
  mutate(Departement_name = Departement)%>%
  tidyr::drop_na()
  write.csv(merged_data, here::here("data","cleaned_data","merged_data.csv"), row.names = FALSE)
  return(merged_data)
}
