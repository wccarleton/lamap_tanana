HPDregion <- function(x,prob,...){
   xdens <- density(x,...)
   xy_dens <- cbind(xdens$x,xdens$y)
   dens_max <- xy_dens[which(xy_dens[,2]==max(xy_dens[,2])),]
   xy_dens_order <- xy_dens[rev(order(xy_dens[,2])),]
   xy_dens_sum <- cbind(xy_dens_order,cumsum(xy_dens_order[,2])/sum(xy_dens_order[,2]))
   regions <- lapply(prob,function(j){
      regionj <- xy_dens_sum[which(xy_dens_sum[,3] <= j),]
      regionj <- regionj[order(regionj[,1]),c(1,2)]
      regionj <- rbind(cbind(regionj[1,1],0),regionj,cbind(regionj[nrow(regionj),1],0))
      return(regionj)
   })
   return(list(regions=regions,maxdens=dens_max))
}

HPDprob <- function(x,val,...){
   xdens <- density(x,...)
   xy_dens <- cbind(xdens$x,xdens$y)
   delta <- abs(diff(xy_dens[,1]))
   delta <- c(delta[1],delta)
   xy_dens <- cbind(xy_dens,xy_dens[,2]*delta)
   total <- sum(xy_dens[,3])
   region <- xy_dens[which(xy_dens[,1] > val),]
   hpd_prob_greater <- sum(region[,3])/total
   return(hpd_prob_greater)
}
