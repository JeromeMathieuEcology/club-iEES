### script pour faire une acp manuelle et comparaison avec le resultat de differentes fonctions

# il y a encore des points a eclaircir comme l'ordre des multiplications pour la projection
# et le scaling et symétrie des points projetes (quelles regles?)


library(ade4)
library(vegan)
library(factoextra)


# data bidon 3 sites, 2 especes
	data_pca <- data.frame( sp1 = c (1, 2 , 3), #, .5
							sp2 = c(1  , 1 , 2   )) #,.5


# 0° centrage des données
	data_pca_centred <- scale(data_pca, scale = F)

	# graph des data
		par(mfrow=c(1,5))
			plot(data_pca, col = "white", pch = 20, cex = 2, asp = 1, main  = "initial")
			text(data_pca, c("sit1","sit2","sit3"))
			plot(data_pca_centred, pch = 20, cex = 2, asp = 1, main  = "centred")
			abline(h = 0, lty = 2, col = "grey60")
			abline(v = 0, lty = 2, col = "grey60")


	# variance sur chaque variable
		apply(data_pca_centred,2,var)


# 1° ACP Manuelle
	# matrice sigma de variance covariance
		(sigma <- var(data_pca_centred))
		# on retrouve bien les variances en diag


	# décomposition de sigma en val propres et vect propres
		(sigma2 <- eigen(sigma))

	# inertie totale
		(inertie <- sum(sigma2$values))
		sum(diag(sigma))

	# vecteurs propres
		sigma2$vectors


	# equations des nouveaux axes : on récupere les vecteurs propres
		# comme les axent passent par 0 il faut juste récupérer la pente qui est y/x et l'utilier pour l'abline
			abline(0 , sigma2$vectors[2,1]/sigma2$vectors[1,1])
			abline(0 , sigma2$vectors[2,2]/sigma2$vectors[1,2])


	# coordonnées des observations projetees dans le plan pca

		# je ne me rapelle plus de l'ordre des multiplications, mais j'ai trouvé 2 solutions
			# il faudrait creuser pour voir la quelle est la bonne

		# version "X x transo" (comme ds les bouquins sur l acp)
			(coords <- as.matrix(data_pca_centred)%*%sigma2$vectors )

		# version "transfo x X" (plus proches des cours de maths) comme la notation est transposee, il faut tout transposer
			t( t(sigma2$vectors)%*%t(as.matrix(data_pca_centred) ))


	# symétrie pour etre ds le mm sens que vegan (a eclaicir)
		coords <- coords*(-1)

	# scaling par val propres # --> pb pour trouver la bonne metrique, cf aide de vegan
		# coords <- coords*(sigma2$values/inertie)^1/2
		# coords <- coords*((sigma2$values/inertie)^1/2)*( (nrow(coords)-1)*inertie)^1/4
		# coords <- coords/sigma2$values
		# coords <- coords/((sigma2$values)^1/2)
		# ((sigma2$values/inertie)^1/2)*( (nrow(coords)-1)*inertie)^1/4

	# plot des points projetés
		plot(coords, col = "white"); text(coords, c("sit1","sit2","sit3"), main  = "acp manuelle")
		abline(h = 0, lty = 2, col = "grey60")
		abline(v = 0, lty = 2, col = "grey60")



# ----

# 2° acp fonction de base -> on trouve pareil qu'en manuel
	(pca_base <- prcomp(data_pca))

	# coords des points projetes (on retrouve la mm chose qu'en manuel, ouf!)
		pca_base$x

	# valeurs propres
		pca_base$sdev^2

	# graph
		plot(pca_base$x, col = "white", pch = 20, cex = 2, main  = "acp fonction de base")
		text(pca_base$x, c("sit1","sit2","sit3"))
		abline(h = 0, lty = 2, col = "grey60")
		abline(v = 0, lty = 2, col = "grey60")



# 3° ACP avec vegan
	(pca_vegan <- vegan::rda(data_pca_centred))
	summary(pca_vegan)

	# coordinates des pts projetes
		pca_vegan$CA$u

	# on trouve comme en manuel, mais avec un scaling par variable, il faut trouver la formule
	# ca doit dependre de la valeur propre de chaque axe et du nombre d'obs
		pca_vegan$CA$u/coords

	# graph
		plot(pca_vegan, main = "vegan")




# 4° acp avec ade4
	pca_ade <- dudi.pca(data_pca_centred, scale = F, nf = 2, scannf = FALSE)

	# on trouve mm pas les mm valeurs propres...
	pca_ade$eig

	# coords des points projetes
		pca_ade$li
		coords
		
	# passage des coordonnées aux scores : on divise chaque axe par la racine carre de la v propre associee 
		data.frame(	sc1 = pca_ade$li [,1]/ sqrt(pca_ade$eig[1]),
					sc2 = pca_ade$li [,2]/ sqrt(pca_ade$eig[2]))
		pca_ade$l1

	# plot
		x11()
		fviz_pca_ind(pca_ade)



# garbage

	# longeur de chaque obs
	apply((as.matrix(data_pca_centred)%*%sigma)^2, 1, sum)

	# coordonnées normées par la longeur des obs
	coords_norm <- as.matrix(data_pca_centred)%*%sigma / apply((as.matrix(data_pca_centred)%*%sigma)^2, 1, sum)
	plot(coords_norm)
