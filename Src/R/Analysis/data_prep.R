ksitesdf_raw <- read.csv("../Data/GIS/CSV/tanana_sites_train_rand.csv",as.is=T,head=F)
ksitesdf <- ksitesdf_raw[-which(apply(ksitesdf_raw,1,function(x)any(x==-9999))),]
names(ksitesdf) <- c("id","y","x","pc1","pc2","pc3")
ksitecoords <- as.data.frame(knownsiteCoords(ksitesdf))
names(ksitecoords) <- c("id","x","y")
ksitepcdfs <- knownsitePcdfs(ksitesdf)
