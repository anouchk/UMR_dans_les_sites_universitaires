library(data.table)

#set working directory
setwd('/Users/analutzky/Desktop/UMR_CNRS/dep4_par_regroupement')

Table_UMR=fread('/Users/analutzky/Desktop/UMR_CNRS/dep4_par_regroupement/UMR_sites_dep4_934_UR.csv')

View(Table_UMR)
# -> affichage excel-like

var.names=colnames(Table_UMR)
colnames(Table_UMR)=make.names(var.names)



Table_UMR[,NbSites:=length(unique(Site..nom.court.)),by=Code.Unité.au.31.12.2018]
Table_UMR[,ListeSites:=paste(unique(Site..nom.court.),collapse=', '),by=Code.Unité.au.31.12.2018]

write.csv2(as.data.frame(Table_UMR),file='UMR_with_Liste_sites.csv',fileEncoding = "UTF8")



