library(data.table)

#set working directory
setwd('/Users/analutzky/Desktop/UMR_CNRS/dep4_par_regroupement')

Table_UMR=fread('/Users/analutzky/Desktop/UMR_CNRS/dep4_par_regroupement/UMR_sites_dep4_934_UR.csv')

View(Table_UMR)
# -> affichage excel-like

var.names=colnames(Table_UMR)
colnames(Table_UMR)=make.names(var.names)

Table_UMR[,NbTutelle:=length(unique(nom.court[Type.partenariat..sans.objet.dans.cette.base.ci.=='Tutelle']))+1L,by=Code.Unité.au.31.12.2018]
Table_UMR[,ListeTutelles:=paste(c('CNRS',unique(nom.court[Type.partenariat..sans.objet.dans.cette.base.ci.=='Tutelle'])), collapse=', '),by=Code.Unité.au.31.12.2018]
# Table_UMR[ListeTutelles=='CNRS', ListeTutelles:='CNRS uniquement']


# Décortiquons :
# Table_UMR[,NbTutelle] on crée un colonne nommée NbTutelle. Si elle existait déjà ça la remplacerait
# NbTutelle:= On assigne à la variable NbTutelle l'opétation suivante
# lentght(unique(a)) Ce serait le nombre d'occurrences uniques de "a"
# Type.partenariat=='Tutelle' c'est une variable bouléenne qui vaut true ou false
# Donc la somme c'est le nb de fois où c'est égal à true, c'est-à-dire où lacondition est vérifiée
# by=Code.Unité.au.31.12.2018 par UMR distincte

# pourquoi 1L au lieu de 1 ?
# Type of RHS ('double') must match LHS ('integer'). To check and coerce would impact performance too much for the fastest cases. Either change the type of the target column, or coerce the RHS of := yourself (e.g. by using 1L instead of 1)
# En fait R ne t'embête pas avec les types, mais data.table ne fait pas le boulot pour aller plus vite. Donc il faut l'aider.

# Quant à paste, il met dans un seul vecteur les éléments épars (ici les occurrences uniques des noms courts des tutelles), avec un séparateur qu'on choisit (collapse=)
# par UMR distincte

write.csv2(as.data.frame(Table_UMR),file='UMR_with_Liste_sites.csv',fileEncoding = "UTF8")

