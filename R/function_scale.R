# merged_data<-read_csv(here::here("data","cleaned_data","merged_data.csv"))
# merged_data%>%select(-2)->merged_data
# #Je veux rescale toutes les colonnes sauf la colonne "Departement_name" et Code
# merged_data%>%mutate_if(is.numeric, .~rescale(.,to = c(0,10)))->scaled_data
# scaled_data%>%View
# scaled_data <-merged_data%>%
#   mutate(across(-c(Code, Departement), ~ as.numeric(as.character(.))))%>%
#   mutate(across(
#     .cols = -c(Code, Departement), # Exclut les colonnes `Code` et `département`
#     .fns = ~ rescale(., to = c(0, 10)) # Applique `rescale` aux colonnes sélectionnées
#   ))
# scaled_data%>%View
