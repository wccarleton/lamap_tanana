site1 <- read.csv("../Data/GIS/raster_sample.txt",as.is=T,head=F)
site1 <- site1$V3[-which(is.na(site1$V3))]
site1 <- data.frame(site=rep("Known Site",length(site1)),Elevation=site1)
site1_rng <- range(site1$Elevation)
site1_density <- density(site1$Elevation)
site1_pdf <- approxfun(x=site1_density$x,y=site1_density$y)
site1_pdf_slice <- as.data.frame(approx(x=site1_density$x,y=site1_density$y,xout=c(1250:1300)))
site1_int_total <- integrate(site1_pdf,lower=site1_rng[1],upper=site1_rng[2])$value
site1_int <- integrate(site1_pdf,lower=1250,upper=1300)$value/site1_int_total

site1_pdf_slice$site <- factor(rep("T",dim(site1_pdf_slice)[1]))

df <- data.frame(x=site1_density$x,y=site1_density$y)
#df[,1] <- factor(df[,1])
p1 <- ggplot(df,aes(x=x,y=y)) +
        geom_area(alpha=0.25,colour="black") +
        geom_area(data=site1_pdf_slice,aes(x=x,y=y),colour="black",alpha=0.5) +
        labs(y="Density",x="Variable Value (PC3)") +
        annotate("text", x = 1275, y = 0.001, label = paste("p = ",format(site1_int,digits=2),sep=""),family="Times",colour="white") +
        theme_minimal() +
        theme(text = element_text(family="Times", size=12),
                plot.title = element_text(hjust = 0.5))
p1

ggsave(filename="../Images/explainer.png",
      device = "png",
      height = 10,
      width = 12,
      units = "cm",
      scale = 1.5,
      dpi = 1000)
