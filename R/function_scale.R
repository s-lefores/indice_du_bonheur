function_scaled_data<-function(){merged_data<-readr::read_csv(here::here("data","cleaned_data","merged_data.csv"))
merged_data%>%select(-2)->merged_data

scaled_data <-merged_data%>%
  mutate(across(-c(Code, Departement), ~ as.numeric(as.character(.))))%>%
  mutate(across(
    .cols = -c(Code, Departement), # Exclut les colonnes `Code` et `département`
    .fns = ~ rescale(., to = c(0, 10)) # Applique `rescale` aux colonnes sélectionnées
  ))
write.csv(scaled_data,here::here("data","cleaned_data","scaled_data.csv"), row.names = FALSE)
return(scaled_data)
}
