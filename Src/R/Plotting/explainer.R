site1_pc3 <- density(ksitesdf[which(ksitesdf$site==1),"pc3"])
site2_pc3 <- density(ksitesdf[which(ksitesdf$site==2),"pc3"])

site1_pc3_pdf <- approxfun(x=site1_pc3$x,y=site1_pc3$y)
site2_pc3_pdf <- approxfun(x=site2_pc3$x,y=site2_pc3$y)

site1_pc3_pdf_slice <- as.data.frame(approx(x=site1_pc3$x,y=site1_pc3$y,xout=c(-10:10)))
site2_pc3_pdf_slice <- as.data.frame(approx(x=site2_pc3$x,y=site2_pc3$y,xout=c(-10:10)))

site1_int_total <- integrate(site1_pc3_pdf,lower=-228,upper=195)$value
site2_int_total <- integrate(site2_pc3_pdf,lower=-238,upper=244)$value
site1_int <- integrate(site1_pc3_pdf,lower=-10,upper=10)$value/site1_int_total
site2_int <- integrate(site2_pc3_pdf,lower=-10,upper=10)$value/site2_int_total

site1_pc3_pdf_slice$site <- factor(rep("T",21))

df <- as.data.frame(ksitesdf[which(ksitesdf$site %in% c(1,2)),])
df[,1] <- factor(df[,1])
p1 <- ggplot(df,aes(pc3,colour=site,fill=site)) +
        geom_density(alpha=0.25) +
        geom_area(data=site1_pc3_pdf_slice,aes(x=x,y=y),alpha=0.5) +
        labs(y="Density",x="Variable Value (PC3)") +
        annotate("text", x = 0, y = 0.0005, label = paste("p = ",format(site2_int,digits=2),sep=""),family="Times") +
        annotate("text", x = 0, y = 0.002, label =  paste("p = ",format(site1_int,digits=2),sep=""),family="Times") +
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
