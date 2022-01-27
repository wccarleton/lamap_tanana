par(family="serif",bg="white")
lamap_freqs_rand <- round(lamap_class_sites_mat$count/sum(lamap_class_sites_mat$count),2)
plotobj <- barplot(lamap_class_sites_mat$count/sum(lamap_class_sites_mat$count),
                  main="Frequency of Sites in each LAMAP Class",names=c(1:5),
                  ylab="% of Sites",
                  xlab="LAMAP Class",
                  ylim=c(0,0.3))
text(x=plotobj,
      y=lamap_freqs_rand,
      pos=3,
      labels=c(lamap_freqs_rand))
###
dev.copy(png,file="../Images/lamap_freqs_rand.png",height=1000,width=1500,units="px",res=150)
dev.off()
