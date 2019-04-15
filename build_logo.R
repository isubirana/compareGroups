devtools::install_github("GuangchuangYu/hexSticker")

library(hexSticker)


library(compareGroups)
data(predimed)


png("man/figures/favicon.png", 480*10/7, 480*7/7)
par(mar=c(0,0,0,0))
plot(1, 1, type="n", axes=FALSE, xlim=c(0,1), ylim=c(0,1), xlab="", ylab="")
abline(v=c(0.15,0.85), h=0.85, lwd=3)
mtext("N", 3, line=-4, cex=4)
mtext(expression(bar(x) %+-% sigma), 3, line=-9, cex=4)
mtext("n (%)", 3, line=-14, cex=4)
mtext("Med [Q1;Q3]", 3, line=-19, cex=4)
dev.off()


png("man/figures/subplot.png", 480*7/5, 480*7/7,bg = "transparent")
par(mar=c(0,0,0,0))
plot(1, 1, type="n", axes=FALSE, xlim=c(0,2), ylim=c(0,2), xlab="", ylab="")
# text(1, 1, expression(bar(x) %+-% sigma),cex=10, adj = c(0.5, 0.5), font=3, col="white")
# mtext("n (%)", 3, line=-20, cex=8)
dev.off()


png("man/figures/subplot.png", 480*7/4, 480*7/7,bg = "transparent")
par(mar=c(0,0,0,0))
boxplot(iris[,1]~iris[,5],col=2:4,axes=FALSE,lwd=3,border="white")
# plot(1, 1, type="n", axes=FALSE, xlim=c(0,2), ylim=c(0,2), xlab="", ylab="")
# text(1, 1, expression(bar(x) %+-% sigma),cex=10, adj = c(0.5, 0.5), font=3, col="white")
# mtext("n (%)", 3, line=-20, cex=8)
dev.off()


png("man/figures/subplot.png", 480*7/4, 480*7/7,bg = "transparent")
par(mar=c(0,0,0,0))
plot(1,1,xlim=c(-1,1),ylim=c(-1,1),axes=FALSE, xlab="",ylab="")
abline(v=0,h=0,lwd=4,col="white")
text(-0.5,0.5,expression(bar(x)), cex=9,col="white")
text(0.5,0.5,expression(sigma^2), cex=9,col="white")
text(-0.5,-0.5,"N", cex=9,col="white")
text(0.5,-0.5,"%", cex=9,col="white")
dev.off()


sticker("man/figures/subplot.png",
        package="compareGroups", dpi=300, 
        p_size=17, p_family="wqy-microhei",p_x=1, p_y=0.60,  
        s_x=1, s_y=1.20, s_width=0.85, s_height=0.60,
        spotlight = TRUE, l_x=1, l_y=0.9,asp = 1,
        filename="man/figures/logo.png")

library(pkgdown)
build_favicon()
build_home()
build_site()



export2md(descrTable(group~., predimed, hide.no="no", type=1, sd.type=3)[1:5],strip = TRUE, 
          first=TRUE,background=grey(0.9),header.background="blue",header.color="white", header.label=c("p.overall"="p-value"))
