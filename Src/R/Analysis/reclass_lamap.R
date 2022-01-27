lamap_quants <- quantile(lamap_vals_sample,probs=seq(0,1,0.2))
lamap_quants[6] <- lamap_quants[6]+1e-07
lamap_classes <- cbind(0:5,lamap_quants)
lamap_class_sample <- sapply(lamap_vals_sample,function(x){
  min(lamap_classes[which(lamap_classes[,2] > x),1])})
lamap_class_sites <- sapply(lamap_vals,function(x){
  min(lamap_classes[which(lamap_classes[,2] > x),1])})
lamap_class_sites_mat <- data.frame(lamap=0:4,count=as.matrix(c(0,(table(lamap_class_sites)))))
