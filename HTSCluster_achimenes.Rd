require(HTSCluster)
require(HTSFilter)

AP.counts.matrix = as.matrix(read.table('Ach_patens_okay.isoforms.counts.matrix',
                                        rownames=1, header=T))

# filter data to remove low counts
AP.counts.filter = HTSBasicFilter(AP.counts.matrix,
                                  method='norm',
                                  cutoff.type='value',
                                  cutoff=1,
                                  normalization='TMM')

# select filtered data and round 
AP.counts.dat.select = AP.counts.filter$filteredData
AP.counts.dat.select = round(AP.counts.dat.select, digits=0)

# perform clustering 5 independent times
AP.counts.clus1 = PoisMixClusWrapper(y=AP.counts.dat.select,
                                    gmin=1,
                                    gmax=60,
                                    conds=c(1,2,3),
                                    lib.type='TMM',
                                    init.runs=5,
                                    alg.type='EM',
                                    split.init=T)
summary(AP.counts.clus)
