#---- init_bloc ----
library(ggplot2)

#---- bloc_code ----
#le commentaire précédent avec les tirets est lu par read_chunck comme un titre. sans les tirets, c'est un commentaire "standard"
x = 1:10
y = exp(x)

knitr::kable(data.frame(x=x, y= y))

#---- bloc_code2 ----
ici, je peux même quelque chose qui n'est pas du code R, car si le chunck n'est pas appelé dans le markdown, il n'est pas exécuté, ni vérifier.
