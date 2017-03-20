library(ape)

# load the newick tree file
tree = read.tree('achimenes.tre')

plot(tree,cex=1.5,edge.width=5,font=3,root.edge=T,label.offset=7,node.depth=2,type='cladogram')

# now to add some character states to the tips of the cladogram
# 1. pollination syndrome
tiplabels(pch=c('H','H','L','A','E','E','E','A','A','L','A','L','A','L','L','H','H','A','A','A','A','E','A','H'),
	adj=1.5,cex=1.5)

# 2. primary flower color
tiplabels(pch=22,bg=c('red','yellow','purple','white','white','purple','purple','white','yellow','purple','white','purple','white',
	'purple','purple','red','red','white','white','white','white','white','purple','red'),
	adj=3,cex=4)

# 3. corolla shape
tiplabels(pch=c("=","=","+","+","<","<","<","+","+","+","+","+","<","+","+","+","+","<","<","<","<","<","<","="),
	adj=4.5,cex=2)

# 4. corolla gibbosity
tiplabels(pch=21,bg='black','adj=6,cex=c(1.5,3,3,1.5,1.5,1.5,1.5,0,0,3,0,1.5,0,0,0,1.5,0,0,0,0,0,1.5,0,0))

# Label the subclades of the genus
edgelabels(edge=c(2,27,34),bg='white',tex=c('C','B','A'),cex=3,frame='circle')

# Label the taxa sampled in the current study
tiplabels(tip=c(10,14,17,18),pch=8,bg='black',adj=13,cex=1.5)
