rasterpath <- "../Data/GIS/Raster/Stack/tanana_pca_rnd_clp.tif"
#validate_sites <- read.csv("../Data/GIS/CSV/tanana_sites_valid_post10.csv")
#site_coords <- cbind(as.numeric(validate_sites[,"x"]),as.numeric(validate_sites[,"y"]))
rasterdata <- stack(rasterpath)
observedcell_sample <- as.data.frame(sampleRandom(rasterdata,10000,xy=T))
#steps <- c(80,80,80)
#steps <- c(65,51,49)
steps <- c(58,61,51)
#steps <- c(40,40,40)
#steps <- c(29,30,25)
lamap_vals_sample <- c()
pb <- txtProgressBar(min=1,max=nrow(observedcell_sample),style=3)
for(j in 1:nrow(observedcell_sample)){
  lamapoutput <- lamap(observed=observedcell_sample[j,],
                        knownsite_pcdfs=ksitepcdfs,
                        knownsite_coords=ksitecoords,
                        steps=steps,
                        maxsites=12,
                        weightfun="exponential",
                        weightparams=c(0.5),
                        combinations=combos,
                        nosupport=NA,
                        partial=T)
  lamap_vals_sample <- c(lamap_vals_sample,lamapoutput)
  setTxtProgressBar(pb,j)
}

#weightfun="exponential",
#weightparams=c(0.25),
