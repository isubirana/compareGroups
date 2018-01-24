radiograph <- function(file, header = TRUE, save = FALSE, out.file="", ...){
 
 dat <- try(read.table(file, header=header, colClasses="character", ...))
 if (inherits(dat,"try-error"))
  stop(" error in reading data using 'read.table'. Check variable separator character.")

 vec <- paste("********************************************************************************\n* This file contains an overview of the values present for each of the ",ncol(dat),
              "\n* variables in the input file ",file,
              ".\n* The dat in the input file are interpreted as text, and a alphanumerically\n* sorted list of the unique values is provided for each variable.\n********************************************************************************\n\n",sep="")
 
 for(cc in 1:ncol(dat)){
   vec <- c(vec,paste("===================",colnames(dat)[cc],"===================\n",collapse=" "))
   vec <- c(vec,paste(sort(unique(dat[,cc])),collapse="; "),"\n\n")
 }
 if(save)
  write(vec,file=out.file)
 else
  cat(vec)
 
}

