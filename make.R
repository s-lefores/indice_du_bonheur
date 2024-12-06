devtools::install_deps(upgrade = "never")
devtools::load_all()

source(here::here("analyses", "1_chargement_nettoyage_data.R"))

source(here::here("analyses", "2_rescale_variables.R"))

#make report
quarto::quarto_render(input = here::here("index.qmd"))
