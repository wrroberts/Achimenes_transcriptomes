library(ggplot2)

Annotation=read.csv('Annotation.csv',header=T)
data1=melt(Annot)

data1$Category<-factor(data1$Category,levels=c('Unannotated','Annotated Primary','Annotated Alternate'))

ggplot(data1,aes(x=variable,y=value))+
+ 	geom_bar(aes(alpha=Category),stat='identity',width=0.9,size=0.5,color='gray25',position='fill)+
+ 	geom_text(data=data.frame(x=rep(4.5,3),y=c(0.4,0.06,0.85),labels=levels(data1$Category)),
+		aes(x,y,label=labels),color='black',hjust=0,cex=10)+
+	labs(x='', y='Percentage', title='Protein Annotation')+
+	scale_alpha_discrete(range=c(1,0))+
+	theme_classic(base_size=30)+
+	guides(alpha=F)+
+	coord_cartesian(xlim=c(0.5,6))+
+	theme(axis.title.y=element_text(vjust=1.5))

Ortho=read.csv('Orthologs.csv',header=T)
data2=melt(Ortho)

data$Category<-factor(data$Category,levels=c('Unique','Shared others','Shared Achimenes','Core'))

ggplot(data2,aes(x=variable,y=value))+
+	geom_bar(aes(alpha=Category),stat='identity',width=0.9,size=0.5,color='gray25')+
+	geom_text(data=data.frame(x=rep(4.5,4),y=c(32000,24000,20000,10000),labels=levels(data$Category)),
+		aes(x,y,label=labels),color='black',hjust=0,cex=10)+
+	labs(x='',y='Number of proteins',title='Orthogroup composition')+
+	scale_alpha_discrete(range=c(1,0))+
+	theme_classic(base_size=30)+
+	guides(alpha=F)+
+	theme(legend.position='bottom')+
+	coord_cartesian(xlim=c(0.5,5.8))

