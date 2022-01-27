#lamap_class_quant <- c(0.0677,0.162,0.283,0.434,1)
#lamap_class_quant <- c(0.0514,0.128,0.218,0.331,0.462,1)
#lamap_class_quant <- c(0.006951077, 0.091352755, 0.221411481, 0.395633854, 0.908139169)
#lamap_class_quant <- c(0.006951077, 0.091352755, 0.221411481, 0.395633854, 1)# 0.611164045) random
lamap_class_quant <- c(0.004070935, 0.066514150, 0.234904419, 0.389259465, 1)# 0.602212474) #pre10
#lamap_class_equal <- c(0.18,0.361,0.541,0.722,1)
lamap_classes <- cbind(1:5,lamap_class_quant)
lamap_class_sites <- sapply(lamap_vals,function(x){
  min(lamap_classes[which(lamap_classes[,2] > x),1])})
lamap_class_sites_mat_quant <- data.frame(lamap=1:5,count=as.matrix(c(0,(table(lamap_class_sites)))))
###
#lamap_classes <- cbind(1:5,lamap_class_equal)
#lamap_class_sites <- sapply(tanana_sites_random_lamap,function(x){
#  min(lamap_classes[which(lamap_classes[,2] > x),1])})
#lamap_class_sites_mat_equal <- data.frame(lamap=1:5,count=as.matrix((table(lamap_class_sites))))
