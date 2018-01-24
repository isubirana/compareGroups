print.compareSNPs <- function(x,...)
{
  if (attr(x,"groups"))
    cat("*********** Summary of genetic data (SNPs) by groups ***********\n")
  else
    cat("*********** Summary of genetic data (SNPs) ***********\n")  
  if (attr(x,"groups")){
    for (i in 1:length(x)){
      if (i < length(x)){
        x.i<-x[[i]]
        x.i$A1<-ifelse(is.na(x.i$A1),"-",x.i$A1)
        x.i$A2<-ifelse(is.na(x.i$A2),"-",x.i$A2)
        x.i$Hom1.p<-ifelse(is.na(x.i$Hom1.p),0,x.i$Hom1.p)
        x.i$Het.p<-ifelse(is.na(x.i$Het.p),0,x.i$Het.p)
        x.i$Hom2.p<-ifelse(is.na(x.i$Hom2.p),0,x.i$Hom2.p)
        temp<-data.frame(SNP=x.i$SNP,
                         Ntyped=x.i$Ntyped,
                         MAF=paste(format2(x.i[,"MAF"]*100,1),"%",sep=""),
                         Genotypes=I(with(x.i,apply(cbind(paste(A1,A1,sep=""),paste(A1,A2,sep=""),paste(A2,A2,sep="")),1,paste,collapse="|"))),
                         Genotypes.p=with(x.i,apply(cbind(format(format2(Hom1.p*100,1),justify="right"),format(format2(Het.p*100,1),justify="right"),format(format2(Hom2.p*100,1),justify="right")),1,paste,collapse="|")),
                         HWE.p=format2(x.i[,"HWE.p"],3))
        temp$Genotypes<-ifelse(x.i$A1=='-' & x.i$A2=='-','-',
                        ifelse(x.i$A2=='-',apply(cbind(x.i$A1,x.i$A1),1,paste,collapse=""),temp$Genotypes))                            
      }else{
        temp<-x[[i]]
        names(temp)[2]<-"p.value"
        temp[,"p.value"] <- format2(temp[,"p.value"],3)
      }
      cat("\n\n  ***",names(x)[i],"***\n\n")
      printTable(temp)
    }
  } else {
    x$A1<-ifelse(is.na(x$A1),"-",x$A1)
    x$A2<-ifelse(is.na(x$A2),"-",x$A2)
    x$Hom1.p<-ifelse(is.na(x$Hom1.p),0,x$Hom1.p)
    x$Het.p<-ifelse(is.na(x$Het.p),0,x$Het.p)
    x$Hom2.p<-ifelse(is.na(x$Hom2.p),0,x$Hom2.p)      
    temp<-data.frame(SNP=x$SNP,
                     Ntyped=x$Ntyped,
                     MAF=paste(format2(x[,"MAF"]*100,1),"%",sep=""),
                     Genotypes=I(with(x,apply(cbind(paste(A1,A1,sep=""),paste(A1,A2,sep=""),paste(A2,A2,sep="")),1,paste,collapse="|"))),
                     Genotypes.p=with(x,apply(cbind(format(format2(Hom1.p*100,1),justify="right"),format(format2(Het.p*100,1),justify="right"),format(format2(Hom2.p*100,1),justify="right")),1,paste,collapse="|")),
                     HWE.p=format2(x[,"HWE.p"],3))
    temp$Genotypes<-ifelse(x$A1=='-' & x$A2=='-','-',
                    ifelse(x$A2=='-',apply(cbind(x$A1,x$A1),1,paste,collapse=""),temp$Genotypes))                     
    printTable(temp)
  }
}