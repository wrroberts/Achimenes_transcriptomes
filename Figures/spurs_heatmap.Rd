require(ComplexHeatmap)
require(circlize)
require(plyr)
require(viridis)

expr <- read.csv('spur.candidates.csv', header=T)
expr <- expr[complete.cases(expr),]

# Ac
mat1 <- as.matrix(expr[,2:4])
mat1_scaled <- t(apply(mat1, 1, scale))
rownames(mat1_scaled) <- expr[,1]

# Ae
mat2 <- as.matrix(expr[,5:7])
mat2_scaled <- t(apply(mat2, 1, scale))
rownames(mat2_scaled) <- expr[,1]

# Am
mat3 <- as.matrix(expr[,8:10])
mat3_scaled <- t(apply(mat3, 1, scale))
rownames(mat3_scaled) <- expr[,1]

# Ap
mat4 <- as.matrix(expr[,11:13])
mat4_scaled <- t(apply(mat4, 1, scale))
rownames(mat4_scaled) <- expr[,1]

# All
mat5 <- cbind(mat1_scaled, mat2_scaled, mat3_scaled, mat4_scaled)
rownames(mat5) <- expr[,1]

mat <- as.matrix(expr[,2:13])
rownames(mat) <- expr[,1]
mat_scaled <- t(apply(mat, 1, scale))

type <- gsub("\\w+_","", colnames(mat))

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

ht1 <- Heatmap(mat_scaled[,1:3], 
               cluster_columns=FALSE, 
               cluster_rows=FALSE, 
               col=colorRamp2(c(-1,0,1), viridis::viridis(3)), 
               show_row_names=FALSE, 
               top_annotation=haAc, 
               name='expression')

ht2 <- Heatmap(mat_scaled[,4:6],
               cluster_columns=FALSE,
               cluster_rows=FALSE,
               col=colorRamp2(c(-1,0,1), viridis::viridis(3)), 
               show_row_names=FALSE, 
               top_annotation=haAe, 
               show_heatmap_legend=FALSE)

ht3 <- Heatmap(mat_scaled[,7:9],
               cluster_columns=FALSE,
               cluster_rows=FALSE,
               col=colorRamp2(c(-1,0,1), viridis::viridis(3)), 
               show_row_names=FALSE, 
               top_annotation=haAm, 
               show_heatmap_legend=FALSE)

ht4 <- Heatmap(mat_scaled[,10:12],
               cluster_columns=FALSE,
               cluster_rows=FALSE,
               col=colorRamp2(c(-1,0,1), viridis::viridis(3)), 
               show_row_names=TRUE, 
               top_annotation=haAp, 
               show_heatmap_legend=FALSE,
               row_names_gp = gpar(cex=1))

ht_list <- ht1 + ht2 + ht3 + ht4

pdf("spur.heatmap.pdf", width=8, height=8)
draw(ht_list)
dev.off()
