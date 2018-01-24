export2pdf <- function(x, file, compile=TRUE, openfile=TRUE, margin=c(2,2,1,1), ...){

  if (!inherits(x,"createTable"))
    stop("'x' must be of class 'createTable'")

  text<-
  paste("
  \\documentclass[a4paper,titlepage,12pt]{article}
  \\usepackage[english]{babel}
  \\usepackage{longtable}
  \\usepackage{multirow}
  \\usepackage{lscape}
  \\usepackage[top=",margin[1],"cm,bottom=",margin[2],"cm,left=",margin[3],"cm,right=",margin[4],"cm]{geometry}
  \\usepackage[utf8]{inputenc}
  \\begin{document}
  ",
  export2latex(x,file=tempfile(),which = if (inherits(x,"summary.createTable")) 'avail' else 'descr',...)
  ,"
  \\end{document}
  "
  ,sep="")
  
  file.tex <- sub("pdf$","tex",file)
  write(text, file = file.tex)
                    
  if (compile){
    wd <- getwd()
    setwd(dirname(file))
    texi2pdf(file = basename(file.tex), clean = FALSE, quiet = TRUE)
    texi2pdf(file = basename(file.tex), clean = TRUE, quiet = TRUE)
    if (openfile)
      sys(basename(file))
    setwd(wd)
  }
  
  
}





