library(readxl)
library(dplyr)
election_reorganized<-function(){
  data_election <- read_excel("C:/Users/chaubet/Desktop/indice_du_bonheur/data/data_election.xlsx")
  names(data_election)<- str_replace_all(names(data_election), " ", "_")
  data_election%>%select(Code=Code_du_département,
                       DUPONT_AIGNAN=`DUPONT-AIGNAN`,POUTOU,
                       PECRESSE=PÉCRESSE,JADOT,HIDALGO,
                       `LE_PEN`,MACRON,MELENCHON=`MÉLENCHON`,
                       ROUSSEL,`ZEMMOUR`)->data_election
  write.csv(data_election, here::here("data","data_election_reorganized.csv"), row.names = FALSE)
}
