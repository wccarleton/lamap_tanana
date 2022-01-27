#paths
locallibrary <- "/home/carleton/R/x86_64-pc-linux-gnu-library/3.4"
workingdir <- "/home/carleton/project/carleton/Alaska/R_workspaces/"
progressdir <- "/home/carleton/scratch/carleton/Alaska/Results/lamap_progress_alaska_16.txt"
rasterpath <- "/home/carleton/scratch/carleton/Alaska/Data/Rnd/Tiles/Tiles.16.tif"
outputpath <- "/home/carleton/scratch/carleton/Alaska/Results/tanana_lamap_rand_16.tif"

#setwd
setwd(workingdir)

#add locallibrary
#.libPaths(new=locallibrary)
library(Rmpi)
library(snow)
library(lamap)

#get nprocs from command line args
args <- commandArgs(trailingOnly = TRUE)
nprocs <- strtoi(args[1]) -1

cat(paste("Running on",nprocs,"processors.\n",sep=" "))

#LAMAP variables
steps <- c(58,61,51)


#set cluster up
cl <- makeCluster(nprocs,type="MPI")
clusterExport(cl,objects())
clusterEvalQ(cl,setwd(workingdir))
clusterEvalQ(cl,.libPaths(new=locallibrary))
load("./tanana_lamap_rand_v2.RData")
clusterEvalQ(cl,load("./tanana_lamap_rand_v2.RData"))
clusterEvalQ(cl,library(lamap))

cat(paste("Start time: ",Sys.time()),fill=T)

#LAMAP calls here

parLamap(cluster_object=cl,
         rasterpath=rasterpath,
         outputpath=outputpath,
         knownsite_pcdfs=ksitepcdfs,
         knownsite_coords=ksitecoords,
         steps=steps,
         maxsites=15,
         weightfun="exponential",
         weightparams=c(0.5),
         combinations=combos,
         nosupport=NA,
         partial=T,
         progress=progressdir)

#stop cluster and clean up
stopCluster(cl)
mpi.exit()
q("no")
