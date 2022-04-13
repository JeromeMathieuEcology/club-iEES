################################################################################
# Ajouter des lettres de significativé à un graph ggplot2

#Thomas Griat  
################################################################################



#Avoir au prealable la sortie de son modèle type lm ,glm etc.
#Ici on va appeler la sortie du modèle : mod1

#Données : DATA  avec 2 colonnes ;
  #  une variable explicative : FACTEUR
  #  une vairable de réponse : y

library(ggplot2)
library(multcomp) 

#comparaison 2 à 2 via un test de Tukey
  mc_tukey <- glht(mod1, linfct=mcp(FACTEUR="Tukey")) 
  summary(mc_tukey) 

#On recupère les lettres de comparaison
  tuk.cld <- cld(mc_tukey) 
  letters <- tuk.cld$mcletters$Letters
  letters

#On en fait un data.frame
  myletters_df <- data.frame(FACTER=levels(DATA$FACTEUR),letters=letters)
  myletters_df



#Le data frame myletters_df permet alors une incorporation des lettres dans ggplot2 comme cela:
  ggplot(DATA,aes(x=FACTEUR, y=y,fill=FACTEUR)) +
    geom_text(data = myletters_df, aes(label = letters, y = 100 ), colour="black", size=10) 

