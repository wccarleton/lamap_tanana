rasterpath <- "../Data/GIS/Raster/Stack/tanana_pca_rnd_clp.tif"
validate_sites <- read.csv("../Data/GIS/CSV/tanana_sites_valid_post10.csv")
site_coords <- cbind(as.numeric(validate_sites[,"x"]),as.numeric(validate_sites[,"y"]))
rasterdata <- stack(rasterpath)
#steps <- c(80,80,80)
#steps <- c(65,51,49)
steps <- c(58,61,51)
#steps <- c(40,40,40)
#steps <- c(29,30,25)
lamap_vals <- c()
for(j in 1:nrow(validate_sites)){
  observedxy <- matrix(site_coords[j,],ncol=2)
  observedcell <- as.data.frame(extract(rasterdata, observedxy))
  observedcell <- cbind(x=observedxy[1],y=observedxy[2],observedcell)
  lamapoutput <- lamap(observed=observedcell,
                        knownsite_pcdfs=ksitepcdfs,
                        knownsite_coords=ksitecoords,
                        steps=steps,
                        maxsites=12,
                        weightfun="exponential",
                        weightparams=c(0.5),
                        combinations=combos,
                        nosupport=NA,
                        partial=T)
  lamap_vals <- c(lamap_vals,lamapoutput)
}
