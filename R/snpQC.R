snpQC <- function(X,sep,verbose)
{

    X<-setupSNP(X,1:ncol(X),sep=sep)
    snps<-attr(X,"label.SNPs")
    snp.sum<-data.frame(SNP=snps,
                        Ntotal=NA,    # Total number of samples for which genotyping was attempted
                        Ntyped=NA,    # Number of genotypes called
                        Typed.p=NA,   # Percentage genotyped
                        Miss.ct=NA,   # Number of missing genotypes
                        Miss.p=NA,    # Proportion of missing genotypes
                        Minor=NA,     # Minor Allele
                        MAF=NA,       # Minor allele frequency
                        A1=NA,        # Allele 1
                        A2=NA,        # Allele 2
                        A1.ct=NA,     # Count Allele 1
                        A2.ct=NA,     # Count Allele 2
                        A1.p=NA,      # Frequency of Allele 1
                        A2.p=NA,      # Frequency of Allele 2
                        Hom1=NA,      # Allele 1 Homozygote
                        Het=NA,       # Heterozygote
                        Hom2=NA,      # Allele 2 Homozygote
                        Hom1.ct=NA,   # Allele 1 Homozygote count
                        Het.ct=NA,    # Heterozygote Count
                        Hom2.ct=NA,   # Allele 2 Homozygote count
                        Hom1.p=NA,    # Frequency of Allele 1 Homozygote
                        Het.p=NA,     # Heterozygote frequency
                        Hom2.p=NA,    # Frequency of Allele 2 Homozygote
                        HWE.p=NA,
                        row.names=snps,
                        stringsAsFactors=FALSE
                       )

    # Compute genotyping success statistics
    snp.sum[,"Ntotal"]  <- nrow(X) 
    snp.sum[,"Ntyped"]  <- apply(X[,snps,drop=FALSE], 2, function(i) sum(!is.na(i)))
    snp.sum[,"Typed.p"] <- round(snp.sum[,"Ntyped"]/snp.sum[,"Ntotal"],3)
    snp.sum[,"Miss.ct"] <- snp.sum[,"Ntotal"] - snp.sum[,"Ntyped"]
    snp.sum[,"Miss.p"]  <- round(snp.sum[,"Miss.ct"]/snp.sum[,"Ntotal"],3)

    # Create an object to store results
    tm <- rep(NA,ncol(snp.sum)); names(tm) <- colnames(snp.sum); tm <- tm[-(c(1:6,ncol(snp.sum)))]

    # loop over SNPs
    snp.sum[,names(tm)] <- t(sapply(snps, function(snp.i){
        if (all(is.na(X[,snp.i])))  # no data
          return(tm)
        sm<-summary(X[!is.na(X[,snp.i]),snp.i])
        if(length(sm$allele.names)>2){
          snp.sum[snp.i,] <-NA
        } else {
          # Alleles
          tm["Minor"] <- rownames(sm$allele.freq)[which.min(sm$allele.freq[,2])]
          tm["MAF"]   <- round(min(sm$allele.freq[,2]),1)/100
          alels<-sm$allele.names
          if(length(alels)==2){
            tm[c("A1","A2")]<-alels
            tm[c("A1.ct","A2.ct")]<-sm$allele.freq[alels,"frequency"]
            tm[c("A1.p","A2.p")]<-round(sm$allele.freq[alels,"percentage"],digits=1)/100
          }
          if(length(alels)==1){
            tm[c("A1")]<-alels
            tm[c("A1.ct")]<-sm$allele.freq[alels,"frequency"]
            tm[c("A1.p")]<-round(sm$allele.freq[alels,"percentage"],digits=1)/100
          }
          # Genotypes
          gts <- attr(sm$genotype.freq,"dimnames")[[1]]; gts <- c(gts,rep(NA,3-length(gts)))
          tm[c("Hom1","Het","Hom2")] <- gts
          tm[c("Hom1.ct","Het.ct","Hom2.ct")][!is.na(gts)] <- sm$genotype.freq[,"frequency"]
          tm[c("Hom1.p","Het.p","Hom2.p")][!is.na(gts)] <- round(sm$genotype.freq[,"percentage"],1)/100
        }
        return(tm)    
    }))
    
    # Hardy-Weinberg test
    #require(HardyWeinberg)    
    hw <- as.matrix(snp.sum[,c("Hom1.ct","Het.ct","Hom2.ct")])
    hw[is.na(hw)] <- 0; hw <- matrix(as.numeric(hw),ncol=ncol(hw))
    snp.sum$HWE.p[rowSums(hw)>0]<-HWChisqMat(hw[rowSums(hw)>0,,drop=FALSE], verbose=verbose)$pvalvec

    # Set classes and return results
    numvar <- c("Ntotal","Ntyped","Typed.p","Miss.ct","Miss.p","MAF","A1.ct","A2.ct","A1.p","A2.p","Hom1.ct","Het.ct","Hom2.ct","Hom1.p","Het.p","Hom2.p","HWE.p")
    for(i in numvar) snp.sum[,i] <- as.numeric(snp.sum[,i])
    return(snp.sum)
}





