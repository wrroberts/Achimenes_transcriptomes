require(ComplexHeatmap)
require(circlize)
require(plyr)
require(viridis)

expr <- read.csv('Flowering.csv',header=T)
expr <- expr[complete.cases(expr),]
expr <- expr[ order(expr$primary.role, expr$expression.domain),]

mat1 <- as.matrix(expr[,3:5], colnames(expr[,3:5]))
#base_mean1 <- rowMeans(mat1)
mat1_scaled <- t(apply(mat1, 1, scale))
mat1_scaled[is.na(mat1_scaled)] <- 0
rownames(mat1_scaled) <- expr[,1]

mat2 <- as.matrix(expr[,6:8], colnames(expr[,6:8]))
#base_mean2 <- rowMeans(mat2)
mat2_scaled <- t(apply(mat2, 1, scale))
mat2_scaled[is.na(mat2_scaled)] <- 0
rownames(mat2_scaled) <- expr[,1]

mat3 <- as.matrix(expr[,9:11], colnames(expr[,9:11]))
#base_mean3 <- rowMeans(mat3)
mat3_scaled <- t(apply(mat3, 1, scale))
mat3_scaled[is.na(mat3_scaled)] <- 0
rownames(mat3_scaled) <- expr[,1]

mat4 <- as.matrix(expr[,12:14], colnames(expr[,12:14]))
#base_mean4 <- rowMeans(mat4)
mat4_scaled <- t(apply(mat4, 1, scale))
mat4_scaled[is.na(mat4_scaled)] <- 0
rownames(mat4_scaled) <- expr[,1]

mat5<-cbind(mat1_scaled, mat2_scaled, mat3_scaled, mat4_scaled)
rownames(mat5) <- expr[,1]

mat <- as.matrix(expr[,3:14], colnames(expr))
rownames(mat) <- expr[,1]
base_mean <- rowMeans(mat)
mat_scaled <- t(apply(mat, 1, scale))

type = gsub("\\w+_","", colnames(mat))
#species = gsub("","_\\w",colnames(mat))
df = data.frame(species = c(rep('Ac',3), rep('Ae',3), rep('Am',3), rep('Ap',3)),
                stage = type)

df2 = data.frame(stage = type)

# Top Annotation
ha = HeatmapAnnotation(df = df2, text = anno_text(df$species),
                       col = list(stage=c('bud' = 'gray90','stageD' = 'gray50', 'preA' = 'gray10')),
                       gap = unit(2, 'mm'))

# Primary Role
ha2 = rowAnnotation(df=expr[2], col=list(primary.role=c('flowering time' = 'gold',
                                                        'organ development' = 'navy',
                                                        'floral repressor' = 'indianred')),
                    gap = unit(4, 'mm'),
                    show_annotation_name = TRUE)

# Expression Domain
ha3 = rowAnnotation(df=expr[15], col=list(expression.domain=c('floral meristem' = 'red',
                                                              'floral organs' = 'gold',
                                                              'inflorescence' = 'black',
                                                              'indistinct' = 'dodgerblue')),
                    gap = unit(4,'mm'),
                    show_annotation_name = TRUE)

# Family
ha4 = rowAnnotation(df=expr[16], col=list(family=c('MADS-box' = 'black',
                                                              'AP2/ERF' = 'green',
                                                              'others' = 'white')),
                    gap = unit(4, 'mm'),
                    show_annotation_name = TRUE)

# Flower Developmental Genes 

pdf("fl.dev.heatmap.pdf", width=12, height=14)
ht = Heatmap(mat5, name='expression', top_annotation = ha, cluster_columns=TRUE,
        row_names_gp = gpar(cex=0.7),
        col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
        show_row_dend = TRUE,
        cluster_rows = TRUE,
        clustering_distance_rows = "minkowski",
        clustering_method_rows = "ward.D2",
        clustering_distance_columns = "minkowski",
        clustering_method_columns = "ward.D2",
        row_names_side = 'right',
        split = expr$primary.role,
        gap = unit(2, 'mm'),
        column_dend_reorder=FALSE,
        column_dend_height = unit(15, 'mm')) + ha3 + ha4
        #combined_name_fun = NULL) + ha3 + ha4

draw(ht, annotation_legend_side = 'bottom', heatmap_legend_side = 'bottom')
decorate_annotation("stage", {grid.text("stage", unit(25, 'cm'), just='left')})
#decorate_annotation("species", {grid.text("species", unit(20.5, 'cm'), just='left')})
dev.off()

##############

# MADS-box genes

expr <- read.csv('Flowering.csv',header=T)
expr <- expr[complete.cases(expr),]
expr2 <- expr[ order(expr$family),]
expr2 <- expr2[ which(expr2$family == 'MADS-box'), ]

mat <- as.matrix(expr2[,3:14])
mat_scaled <- t(apply(mat, 1, scale))
mat_scaled[is.na(mat_scaled)] <- 0
rownames(mat_scaled) <- expr2[,1]

# Ac MADS-box
mat6 <- as.matrix(expr2[,3:5], colnames(expr2[,3:5]))
mat6_scaled <- t(apply(mat6, 1, scale))
mat6_scaled[is.na(mat6_scaled)] <- 0
rownames(mat6_scaled) <- expr2[,1]

# Ae MADS-box
mat7 <- as.matrix(expr2[,6:8], colnames(expr2[,6:8]))
mat7_scaled <- t(apply(mat7, 1, scale))
mat7_scaled[is.na(mat7_scaled)] <- 0
rownames(mat7_scaled) <- expr2[,1]

# Am MADS-box
mat8 <- as.matrix(expr2[,9:11], colnames(expr2[,9:11]))
mat8_scaled <- t(apply(mat8, 1, scale))
mat8_scaled[is.na(mat8_scaled)] <- 0
rownames(mat8_scaled) <- expr2[,1]

# Ap MADS-box
mat9 <- as.matrix(expr2[,12:14], colnames(expr2[,12:14]))
mat9_scaled <- t(apply(mat9, 1, scale))
mat9_scaled[is.na(mat9_scaled)] <- 0
rownames(mat9_scaled) <- expr2[,1]

dfAc = data.frame(species = c(rep('Ac',3)),
                stage = type)

dfAe = data.frame(species = c(rep('Ae',3)),
                  stage = type)

dfAm = data.frame(species = c(rep('Am',3)),
                  stage = type)

dfAp = data.frame(species = c(rep('Ap',3)),
                  stage = type)

df2 = data.frame(stage = c('bud','stageD','preA'))

# Top Annotation
haAc = HeatmapAnnotation(df=df2,
                         text = anno_text(dfAc$species),
                         col = list(stage=c('bud' = 'gray90','stageD' = 'gray50','preA' = 'gray10')),
                         gap = unit(2,'mm'),
                         show_legend = TRUE)

haAe = HeatmapAnnotation(df=df2,
                         text = anno_text(dfAe$species),
                         col = list(stage=c('bud' = 'gray90','stageD' = 'gray50','preA' = 'gray10')),
                         gap = unit(2,'mm'),
                         show_legend = FALSE)

haAm = HeatmapAnnotation(df=df2,
                         text = anno_text(dfAm$species),
                         col = list(stage=c('bud' = 'gray90','stageD' = 'gray50','preA' = 'gray10')),
                         gap = unit(2,'mm'),
                         show_legend = FALSE)

haAp = HeatmapAnnotation(df=df2,
                         text = anno_text(dfAp$species),
                         col = list(stage=c('bud' = 'gray90','stageD' = 'gray50','preA' = 'gray10')),
                         gap = unit(2,'mm'),
                         show_legend = FALSE)

pdf("MADS.heatmap.pdf", width=10, height=8)
ht6 = Heatmap(mat6_scaled,
              cluster_columns=FALSE, cluster_rows=TRUE,
              col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
              show_row_names=FALSE,
              top_annotation=haAc,
              name = 'expression',
              split = expr2$primary.role,
              gap = unit(2, 'mm'),
              row_title_gp = gpar(cex=0.75),
              clustering_method_rows = "ward.D2",
              clustering_distance_rows = "minkowski",
              show_row_dend = FALSE)
ht7 = Heatmap(mat7_scaled,
              cluster_columns=FALSE, cluster_rows=TRUE,
              col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
              show_row_names=FALSE,
              top_annotation=haAe,
              show_heatmap_legend=FALSE)
ht8 = Heatmap(mat8_scaled,
              cluster_columns=FALSE, cluster_rows=TRUE,
              col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
              show_row_names=FALSE,
              top_annotation=haAm,
              show_heatmap_legend=FALSE)
ht9 = Heatmap(mat9_scaled,
              cluster_columns=FALSE, cluster_rows=TRUE,
              col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
              show_row_names=TRUE,
              top_annotation=haAp,
              show_heatmap_legend=FALSE) + ha3

ht_list <- ht6 + ht7 + ht8 + ht9

draw(ht_list)
dev.off()

ht1 <- Heatmap(mat_scaled[,1:3],
               cluster_columns=FALSE,
               cluster_rows=FALSE,
               col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
               show_row_names=FALSE,
               top_annotation=haAc,
               show_heatmap_legend=TRUE)
ht2 <- Heatmap(mat_scaled[,4:6],
               cluster_columns=FALSE,
               cluster_rows=FALSE,
               col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
               show_row_names=FALSE,
               top_annotation=haAe,
               show_heatmap_legend=FALSE)
ht3 <- Heatmap(mat_scaled[,7:9],
               cluster_columns=FALSE,
               cluster_rows=FALSE,
               col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
               show_row_names=FALSE,
               top_annotation=haAm,
               show_heatmap_legend=FALSE)
ht4 <- Heatmap(mat_scaled[,10:12],
               cluster_columns=FALSE,
               cluster_rows=FALSE,
               col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
               show_row_names=TRUE,
               top_annotation=haAp,
               show_heatmap_legend=FALSE)

ht_list = ht1 + ht2 + ht3 + ht4
draw(ht_list)

mat10<-cbind(mat6_scaled, mat7_scaled, mat8_scaled, mat9_scaled)
rownames(mat10) <- expr2[,1]

# Primary Role
ha2 = rowAnnotation(df=expr2[2], col=list(primary.role=c('flowering time' = 'gold',
                                                        'organ development' = 'navy',
                                                        'floral repressor' = 'indianred')),
                    gap = unit(4, 'mm'),
                    show_annotation_name = TRUE)

# Expression Domain
ha3 = rowAnnotation(df=expr2[15], col=list(expression.domain=c('floral meristem' = 'red',
                                                              'floral organs' = 'gold',
                                                              'inflorescence' = 'black',
                                                              'indistinct' = 'dodgerblue')),
                    gap = unit(4,'mm'),
                    show_annotation_name = FALSE)

pdf("MADS.heatmap.pdf", width=10, height=8)
ht2 = Heatmap(mat10, name='expression', top_annotation = ha, 
              cluster_columns=TRUE,
             row_names_gp = gpar(cex=1),
             col = colorRamp2(c(-1,0,1), viridis::viridis(3)),
             show_row_dend = FALSE,
             cluster_rows = TRUE,
             clustering_distance_rows = "minkowski",
             clustering_method_rows = "ward.D2",
             clustering_distance_columns = "minkowski",
             clustering_method_columns = "ward.D2",
             row_names_side = 'right',
             split = expr2$primary.role,
             gap = unit(2, 'mm'),
             column_dend_reorder=FALSE,
             row_title_gp = gpar(cex=0.75)) + ha3

draw(ht2, annotation_legend_side = 'right', heatmap_legend_side = 'right')
#decorate_annotation("stage", {grid.text("stage", unit(21, 'cm'), just='left')})
#decorate_annotation("species", {grid.text("species", unit(20.5, 'cm'), just='left')})
dev.off()

mat <- as.matrix(expr[,3:14], colnames(expr))
rownames(mat) <- expr[,1]
base_mean <- rowMeans(mat)
mat_scaled <- t(apply(mat, 1, scale))

type = gsub("\\w+_","", colnames(mat))
#species = gsub("","_\\w",colnames(mat))
df = data.frame(species = c(rep('Ac',3), rep('Ae',3), rep('Am',3), rep('Ap',3)),
                stage = type)
ha = HeatmapAnnotation(df=df, col=list(species=c('Ac' = 'royalblue', 'Ae' = 'red',
                                              'Am' = 'gray75', 'Ap' = 'orchid'),
                                       stage=c('bud' = 'gray90','stageD' = 'gray50', 'preA' = 'gray10')),
                       gap = unit(2, 'mm'),
                       show_annotation_name = TRUE)

Heatmap(mat_scaled,name='expression',top_annotation=ha,cluster_columns=FALSE, 
        row_names_gp=gpar(cex=0.5),
        col = colorRamp2(c(-1,0,1), c('darkgreen','black','gold')),
        show_column_names = TRUE,
        km=9) +
  Heatmap(base_mean, name = "mean", show_row_names = FALSE, width = unit(5, 'mm'))



