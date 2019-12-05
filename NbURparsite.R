library(data.table)

#set working directory
setwd('/Users/analutzky/Desktop/UMR_CNRS/dep4_par_regroupement')

Table_UMR=fread('/Users/analutzky/Desktop/UMR_CNRS/dep4_par_regroupement/UMR_sites_dep4_934_UR.csv')

View(Table_UMR)
# -> affichage excel-like

var.names=colnames(Table_UMR)
colnames(Table_UMR)=make.names(var.names)

# Compter le nombre d'UR par site : on prend toutes les lignes, les colonnes c'est le nb d'occurences uniques d'une UR, par site universitaire
Table_UMR[,.(Nombre_de_UR=length(unique(Intitulé.2018))),by=.(Site..nom.court.)]

# PETITE VERIF
# Prendre juste lers lignes du site PSL, afficher les occurences uniques de la colonne listant les intitulés des UR
Table_UMR[Site..nom.court.=='PSL',unique(Intitulé.2018)]

# On rajoute une troisième colonne avec la région
Table_sites=Table_UMR[,.(Nombre_de_UR=length(unique(Intitulé.2018))),by=.(Site..nom.court.,région)]

write.csv2(as.data.frame(Table_sites),file='UMR_nb_UR_par_site.csv',fileEncoding = "UTF8")