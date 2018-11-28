report <- function(x, file, fig.folder, compile=TRUE, openfile=FALSE, title="Report", author, date, ...){

  if (!inherits(x,"createTable"))
    stop("'x' must be of class 'createTable'")
    
  if(inherits(x,"cbind.createTable"))
    stop("function is not implemented for 'cbind.createTable' class object")
  
  bivar<-attr(x,"groups")

  if (missing(fig.folder))
    fig.folder <- paste(sub("\\.pdf$","",file),"figures",sep="_")
  
  if (!fig.folder %in% list.files(dirname(file)))
    dir.create(fig.folder)

  tf<-paste(fig.folder,"/uni_",sep="")
  plot(x,file=tf)
  unilf<-list.files(fig.folder)
  unilf<-unilf[grep("^uni_",unilf)]
  unilf<-paste("./",basename(fig.folder),"/",unilf,sep="")

  if (bivar){
    tf<-paste(fig.folder,"/bivar_",sep="")
    plot(x,bivar=TRUE,file=tf)
    bivarlf<-list.files(fig.folder)
    bivarlf<-bivarlf[grep("^bivar_",bivarlf)]
    bivarlf<-paste("./",basename(fig.folder),"/",bivarlf,sep="")
  }

  unitext<-""
  for (i in unilf){
  figtitle<-sub("uni_","",basename(i))
  figtitle<-sub(".pdf$","",figtitle)
  unitext<-paste(unitext,"
  \\begin{figure}[H]
  \\begin{center}
  \\caption{",figtitle,"}
  \\includegraphics[width=17cm]{",i,"}
  \\end{center}
  \\end{figure}
  ",sep="")
  }

  if (bivar){
    bivartext<-""
    for (i in bivarlf){
    figtitle<-sub("bivar_","",basename(i))
    figtitle<-sub(".pdf$","",figtitle)
    bivartext<-paste(bivartext,"
    \\begin{figure}[H]
    \\begin{center}
    \\caption{",figtitle,"}
    \\includegraphics[width=17cm]{",i,"}
    \\end{center}
    \\end{figure}
    ",sep="")
    }
  }  

  text<-
  paste("
  \\documentclass[a4paper,titlepage,12pt]{article}
  \\usepackage[english]{babel}
  \\usepackage{longtable}
  \\usepackage{hyperref}
  \\usepackage{multirow}
  \\usepackage{lscape}
  \\usepackage[top=2cm,bottom=2cm,left=1cm,right=1cm]{geometry}
  \\usepackage{float}
  \\usepackage[utf8]{inputenc}
  \\usepackage[pdftex]{epsfig}  
  \\DeclareGraphicsRule{.pdftex}{pdf}{.pdftex}{}  
  \\title{",title,"}
  ",
  if (!missing(author)) paste("\\author{",author,"}",sep="")  else ""
  ,"
  ",
  if (!missing(date)) paste("\\date{",date,"}",sep="")  else ""
  ,"
  \\begin{document}
  \\maketitle
  \\tableofcontents
  \\listoftables
  \\listoffigures
  \\newpage
  \\section{Tables}",
  export2latex(x,file=tempfile(),...)
  ,"
  \\newpage
  ",
  export2latex(x,which="avail",file=tempfile(),...)
  ,"
  \\section{Figures}
  \\subsection{univariate}
  ",
  unitext
  ,
  if (bivar) "\\subsection{bivariate}" else ""
  ,
  if (bivar) bivartext else ""
  ,"
  \\end{document}
  "
  ,sep="")
  
  file.tex <- sub("pdf$","tex",file)
  write(text,file=file.tex)
  
  if (compile){
    wd <- getwd()
    setwd(dirname(file))  
    texi2pdf(file = basename(file.tex), clean = FALSE, quiet = TRUE)
    texi2pdf(file = basename(file.tex), clean = TRUE, quiet = TRUE)
    setwd(wd)
  }
  
  
}




