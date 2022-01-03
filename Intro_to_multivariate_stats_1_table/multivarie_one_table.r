# scripts pour faire l'analyse d'un tableau de données
# J.Mathieu | Sorbonne Université
# 29-09-2021

# data
	X <- read.csv("./multivariate_stats_1/TD_R_data.csv")
	idx_sp <- grep("sp[A-Z]", names(X))


# HEATMAPS
	# https://jokergoo.github.io/ComplexHeatmap-reference/book/
	# if needed install package:
	# devtools::install_github("jokergoo/ComplexHeatmap")

	library(ComplexHeatmap)

	# heatmap of all data together
		Heatmap(X)


	# add labels to observations

		# add a categorical label to observations

			row_ha <- rowAnnotation( Zone = X[,"zone_lac"], 
										col = list (Zone = c("milieu" = '#66c2a4',"bord" = '#006d2c')))

			Heatmap(X[,-c(1:4)], left_annotation = row_ha)


		# add a categorical label to observations with specific labels

			row_ha_engl <- rowAnnotation( Zone = X[,"zone_lac"], 
										col = list (Zone = c("milieu" = '#66c2a4', "bord" = '#006d2c')),
										annotation_legend_param = list (title = "Zone", at = c("bord","milieu"), labels = c("Border","Center"))
										)

			Heatmap(X[,-c(1:4)], left_annotation = row_ha_engl)	


		# add two labels to observations with customized colors and custom labels

			row_ha_2labs <- rowAnnotation( Zone = X[,"zone_lac"], 
									 Lake = X[,"lac_ID"],

				 					 col = list ( Zone = c("milieu" = '#66c2a4', "bord" = '#006d2c'),
				 								  Lake = c("A" = '#1b9e77', "B" = '#d95f02', "C" = '#7570b3') 
				 								),
				 					 annotation_legend_param = list (Zone = list(title = "Zone", at = c("bord","milieu"), labels = c("Border","Center")),
				 														Lake = list(title = "Lake", at = c("A","B","C"), labels = c("Creteil","Avon","Foljuif"))
				 													)
				 													
				 						)

			Heatmap(X[,-c(1:4)], left_annotation = row_ha_2labs)	



	# list of heatmaps by block of data
		heat_cat <- Heatmap(X[,c(2:5)], heatmap_legend_param = list(title = "Factors' levesl",title_position = "lefttop-rot"))
		heat_cont <- Heatmap(X[,c(6:10)], heatmap_legend_param = list(title = "Covariates"))
		heat_sp <- Heatmap(X[,grep("sp[A-Z]", names(X))], heatmap_legend_param = list(title = "Species"))

		heat_cat + heat_cont + heat_sp


	# splitting a heatmap

		# heatmap | rows splited by a factor
			Heatmap( X[,-c(1:5)], row_split = factor( X[,"zone_lac"] ) )



		# heatmap | columns splited by a factor
			Heatmap( X[,-c(1:5)], column_split =c( rep( "Environement",6), rep("Species",3) ) )



		# heatmap | columns and rows splited by a factor
			Heatmap( X[,-c(1:5)], column_split =c(rep("Environement",6), rep("Species",3)),
									row_split = factor(X[,"lac_ID"]) )




# DISTANCE MATRICES

	library(vegan)


	# compute distance between samples

		# euclidian distance between samples
			X[ c(1,12), idx_sp ]
			X[ 1, idx_sp ] - X[ 12, idx_sp ]
			sqrt(sum((X[ 1, idx_sp ] - X[ 12, idx_sp ])^2))
			data.matrix( dist(X[ c(1,12), idx_sp ]) ) 

		# euclidian paradox 

			( Xsmall <- X[ c(1,2,7,12), idx_sp ] )	# smaller dataset to work on

			data.matrix( dist(Xsmall) ) 
				# 1-2 more different than 1-12 !
				# 2-7 more different than 1-2 !

			# with hellinger transformation
				Xsmall_h <- decostand(Xsmall, "hellinger")
				data.matrix( dist(Xsmall_h ))	# looks ok	


	# plot distance matrices

		# euclidian matrix
			dist_euclid <- data.matrix(dist( X[, idx_sp] ))

			# distance matrix visualisation
				Heatmap(dist_euclid)	

				Heatmap(dist_euclid, row_split = factor(X[,"region"]), column_split = factor(X[,"region"]) )	
				Heatmap(dist_euclid, row_split = factor(X[,"zone_lac"]), column_split = factor(X[,"zone_lac"]) )
				Heatmap(dist_euclid, row_split = factor(X[,"lac_ID"]), column_split = factor(X[,"lac_ID"]) )	

				Heatmap(dist_euclid, row_split = factor(X[,"lac_ID"]), column_split = factor(X[,"region"]) )



		# hellinger distance (euclidian distance on hellinger transformed data)
			X_h <- decostand(X[,idx_sp], "hellinger")

			dist_hell <- data.matrix(dist(data.matrix(dist( X_h ) )))

			Heatmap(dist_hell)	
			Heatmap(dist_hell, row_split = factor(X[,"region"]), column_split = factor(X[,"region"]) )	




# Ordination


library(ade4)
library(factoextra)

	# Ordination of quantitative data

		# PCA
		# http://www.sthda.com/french/articles/38-methodes-des-composantes-principales-dans-r-guide-pratique/73-acp-analyse-en-composantes-principales-avec-r-l-essentiel
		
			my_pca <- dudi.pca( X[,idx_sp], scannf = FALSE, nf = 2, scale = F)
			my_pca_hell <- dudi.pca( X_h, scannf = FALSE, nf = 2, scale = F)

			# eigenvalues

				fviz_screeplot(my_pca, addlabels = TRUE)

			# analysis of variables

				# Extract the results for variables
				  vars <- get_pca_var(my_pca)
				  vars
				  vars$contrib

				  # variable's coordinates
					  vars$coord
					  my_pca$co

				  apply(vars$contrib,2,sum) # check : contribution of variables sum up to 100%

				# correlation circle
					fviz_pca_var(my_pca)
					fviz_pca_var(my_pca, col.var="contrib",
		             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
		             repel = TRUE) 

				# Plot contributions of variables to PC1
				    fviz_contrib(my_pca, choice = "var", axes = 1, top = 10)


			# analysis of samples

				# Extract the results for individuals
					inds <- get_pca_ind(my_pca)
					inds

				# samples' coordinates
					inds$coord
					my_pca$li


				# plot samples
					# regular pca
						fviz_pca_ind(my_pca)
						fviz_pca_ind(my_pca, col.ind = as.factor(X$lac_ID))

					# hellinger pca
						fviz_pca_ind(my_pca_hell, col.ind = as.factor(X$region))
						fviz_pca_ind(my_pca_hell, col.ind = as.factor(X$lac_ID))


				# ellipses by class
					# regular pca
				    	fviz_pca_ind(my_pca,

				             label = "none", # hide individual labels
				             habillage = X$region, # color by groups
				             addEllipses = TRUE # Concentration ellipses
				             )
				    # hellinger pca
				    	fviz_pca_ind(my_pca_hell,
				             label = "none", # hide individual labels
				             habillage = X$region, # color by groups
				             addEllipses = TRUE # Concentration ellipses
				             )

			# biplot : samples and variables in the same plan

				fviz_pca_biplot(my_pca, repel = TRUE,
				                col.var = "#2E9FDF", # Couleur des variables
				                col.ind = "#696969"  # Couleur des individues
				                )

			# with grouping
				fviz_pca_biplot (my_pca,
				                col.ind = X$region, palette = "jco",
				                addEllipses = TRUE, label = "var",
				                col.var = "grey20", repel = TRUE,
				                legend.title = "Zone")



		# CA
			my_ca <- dudi.coa( X[,idx_sp], scannf = FALSE, nf = 2)	 
			fviz_eig(my_ca)
			fviz_ca_biplot(my_ca, col.row = X$lac_ID, palette = "jco", repel = TRUE)



		# NMDS
		# projection based on ranks
		library(vegan)

			set.seed(156) # for reproducibility
			my_NMDS <- metaMDS(X[,idx_sp],k=2, distance = 'euclidian', try  = 40)



			# quality of projection (stress)
				stressplot(my_NMDS)

			# 2D plan
				ordiplot(my_NMDS)

			# add a continous covariates
				covariates <- envfit (my_NMDS, X[, 5:8])
				ordiplot(my_NMDS)		
				plot(covariates)

			# add convex hulls
				ordiplot(my_NMDS)		
				ordihull(my_NMDS, groups = X$lac_ID, draw="polygon", col="grey90", label = F)

			# add ellipses
				ordiplot(my_NMDS)
				ordiellipse(my_NMDS, groups = X$lac_ID, draw="polygon", col=c("grey10","grey40","grey90"), label = F)

			
				library(ggvegan)

				autoplot(my_NMDS)



		# PCoa	(MDS)

			# any metric distance
				dist_bray <- vegdist(X[,idx_sp], "bray")
			# check that dist matrix is euclidian
				is.euclid(dist_bray)
			# transform to euclidian matrix
				dist_bray_euclid <- cailliez(dist_bray)
			# pCoa
				my_pcoa <- dudi.pco(dist_bray_euclid, scannf = FALSE)

			s.label(my_pcoa$li)
			s.class(my_pcoa$li, factor(X$region), col = c( '#66c2a4', '#d95f02'))





		# kernel PCA

			library(kernlab)


			k_pca <- kpca(~., data = X[,idx_sp], kernel = "rbfdot", kpar=list(sigma=0.001), features = 2)
		
			# get principal component vectors 
				k_pca_v <- pcv(k_pca) 
				kpca_v_df <- as.data.frame(k_pca_v)

			# plot
				library(ggplot2)
				library(ggrepel)

				ggplot(kpca_v_df, aes(x = V1, y = V2, col = X$lac_ID)) + geom_point() + 
							geom_text_repel(label = X$sple_ID) +
							geom_hline(yintercept = 0, linetype = "dotted", color = "grey30") +
							geom_vline(xintercept = 0, linetype = "dotted", color = "grey30") +
							theme_minimal()




		# t sne
			library(Rtsne)

 			my_tsne <- Rtsne(X[,idx_sp], dims = 2, perplexity = 2, verbose = TRUE, max_iter = 500)

			my_tsne_rows <- as.data.frame(my_tsne$Y)

				ggplot(my_tsne_rows, aes(x = V1, y = V2, col = X$lac_ID)) + geom_point() + 
							geom_text_repel(label = X$sple_ID) +
							geom_hline(yintercept = 0, linetype = "dotted", color = "grey30") +
							geom_vline(xintercept = 0, linetype = "dotted", color = "grey30") +
							theme_minimal()


		# SOM
			# todo


	# Ordination of categorical data

		# MCA
		# http://larmarange.github.io/analyse-R/analyse-des-correspondances-multiples.html
		X$region <- factor(X$region)
		X$lac_ID <- factor(X$lac_ID)
		X$zone_lac <- factor(X$zone_lac)
		X$couleur <- factor(X$couleur)
		my_mca <- dudi.acm(X[, 2:5], scannf = FALSE, nf = 3)

		# plot of modalities
			fviz_mca_var(my_mca, repel = TRUE)

			library(RColorBrewer)
			scatter(my_mca,col = brewer.pal(5, "Dark2"))

		# contribution of modalites to axis 1
			fviz_contrib(my_mca, choice = "var", axes = 1)

		# plot of samples
			fviz_mca_ind(my_mca, geom = "point", alpha.ind = .25, habillage = X$lac_ID, addEllipses = TRUE)
		



	# Ordination of mixed data

 		# The differences are that dudi.hillsmith allow to use various row weights, while dudi.mix deals with ordered variables.
 		
 		# Hill-Smith,  FAMD
		# https://lemakistatheux.wordpress.com/category/outils-danalyse-exploratoire/lanalyse-dhill-et-smith/

			my_HS <- dudi.hillsmith(X[,-1], scannf = FALSE, nf = 4)
			scatter(my_HS, posieig = "bottomleft")

			score(my_HS, col = TRUE)


		# Mixed type analysis

			X$col_ordered <- factor(X$couleur, ordered = TRUE, 
                                levels = c("transparent","claire", "bleu", "jaune", "beige", "noir" ))

			my_dmix <- dudi.mix(X[,-grep("sple_ID|couleur$", names(X))], scannf = FALSE, nf = 4)
			scatter(my_dmix, posieig = "bottomleft")

			score(my_dmix, col = TRUE)



