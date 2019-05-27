############################################################################# 
#
#  spss_varlist(FILE) -- extract info about variables from header of
#                        FILE, an SPSS for Windows data file (.sav)
#
# Returns an R data.frame object with a row for each variable, columns in this 
# frame are:-
#  varname		Variable Name, 8-char upper case.
#  varlabel		Variable label, up to 40 char in length.
#  printfmt		Spss PRINT FORMAT mnemonic (A40, F8.2, DATE11, etc).
#  nmiss		An integer value indicating how many missing values 
#                       are defined, 0, 1, 2, or 3. Can also take values -2 or
#                       -3 indicating that  Missing Value 1 and Missing Value 2 
#                       represent a range.
#  missing1		First missing value (or NA).
#  missing2		Second missing value (or NA).
#  missing3		Third missing value (or NA).
#  longname		Long variable name (SPSS version >= 12)
#
# Based on the Perl script  'spssread.pl'  :
# 
#  "spssread.pl - a utility to print info about SPSS data files
#  version 0.2.1 on 16 Jun 2005 by Scott Czepiel <sczepiel@gmail.com>
#  for updates see: <http://czep.net/data/spssread/>"
#
# Format code mnemonics, and Record Type layout information, obtained from
# a document (presumably authored by SPSS Inc.) made available
# at <http://www.wotsit.org>, a site containing file format
# information on hundreds of different file types.
#
# Adapted for use in R by Dave Macfarlane and Isaac Subirana.
# April 2006.
# (dave@imim.es, isubirana@imim.es)
# 
# Usage: spss_varlist(FILENAME)
#############################################################################


spss_varlist <- function(file){
  

	# open the spss sav file for read in binary mode
	sav <- file(file, "rb")


	############################################################################
	# set up a vector to translate format type code to mnemonic
	############################################################################
	ftype <- NULL
	ftype <- c( ftype, 'A') 	#  1  alphanumeric
	ftype <- c( ftype, 'AHEX') 	#  2  alphanumeric hexadecimal
	ftype <- c( ftype, 'COMMA') 	#  3  F format with commas
	ftype <- c( ftype, 'DOLLAR') 	#  4  commas and floating dollar sign
	ftype <- c( ftype, 'F') 	#  5  F default numeric format
	ftype <- c( ftype, 'IB') 	#  6  integer binary
	ftype <- c( ftype, 'PIBHEX') 	#  7  packed integer binary (hexadecimal)
	ftype <- c( ftype, 'P') 	#  8  packed decimal
	ftype <- c( ftype, 'PIB') 	#  9  positive integer binary (unsigned)
	ftype <- c( ftype, 'PK') 	# 10  positive packed decimal (unsigned)
	ftype <- c( ftype, 'RB') 	# 11  floating point binary
	ftype <- c( ftype, 'RBHEX') 	# 12  floating point binary hex
	ftype <- c( ftype, 'UNKNOWN') 	# 13  --NOT USED--
	ftype <- c( ftype, 'UNKNOWN') 	# 14  --NOT USED--
	ftype <- c( ftype, 'Z') 	# 15  zoned decimal
	ftype <- c( ftype, 'N') 	# 16  unsigned with leading spaces
	ftype <- c( ftype, 'E') 	# 17  explicit power of 10
	ftype <- c( ftype, 'UNKNOWN') 	# 18  --NOT USED--
	ftype <- c( ftype, 'UNKNOWN') 	# 19  --NOT USED--
	ftype <- c( ftype, 'DATE') 	# 20  date - dd-mmm-yyyy
	ftype <- c( ftype, 'TIME') 	# 21  time - hh:mm:ss.s
	ftype <- c( ftype, 'DATETIME') 	# 22  date and time
	ftype <- c( ftype, 'ADATE') 	# 23  date - mm/dd/yyyy
	ftype <- c( ftype, 'JDATE') 	# 24  julian date - yyyyddd
	ftype <- c( ftype, 'DTIME') 	# 25  date-time - dd hh:mm:ss.s
	ftype <- c( ftype, 'WKDAY') 	# 26  day of the week
	ftype <- c( ftype, 'MONTH') 	# 27  month
	ftype <- c( ftype, 'MOYR') 	# 28  mmm yyyy
	ftype <- c( ftype, 'QYR') 	# 29  q Q yyyy
	ftype <- c( ftype, 'WKYR') 	# 30  ww WK yyyy
	ftype <- c( ftype, 'PCT') 	# 31  percent - F followed by '%'
	ftype <- c( ftype, 'DOT') 	# 32  like COMMA, switching dot for comma
	ftype <- c( ftype, 'CCA') 	# 33  ) User 
	ftype <- c( ftype, 'CCB') 	# 34  )  programmable
	ftype <- c( ftype, 'CCC') 	# 35  )   currency
	ftype <- c( ftype, 'CCD') 	# 36  ) formats
	ftype <- c( ftype, 'CCE') 	# 37  )
	ftype <- c( ftype, 'EDATE') 	# 38  date - dd.mm.yyyy
	ftype <- c( ftype, 'SDATE') 	# 39  date - yyyy/mm/dd


	variable_record <- function() {

		##################################################
		# variable_record -- Parse one variable record
		#
		# Return a either a vector of components, 
		# or NULL if the dictionary entry corresponded to
		# "continuation of a string var"
		##################################################

		# read variable type code
		TYPECODE <- readBin(sav, integer())

		# if type is not -1, then record is for a numeric var or the
		# first (and only) instance of a string var

		if (TYPECODE != -1) {

			# read label flag
			HASLABEL <- readBin(sav, integer())

			# read missing value format code
			NMISSING <- readBin(sav, integer())

      # read print format code 1st 3 bytes of Print Format 
      PDEC <- readBin(sav, integer(), size=1)	# decimal places
      PWID <- readBin(sav, integer(), size=1)	# column width
      PTYP <- readBin(sav, integer(), size=1)	# format type
      IGNORE <- readChar(sav, 1, useBytes=TRUE)		# ignore 4th byte, always 0

      # construct mnemonic with width (and dec.digits if non zero)
      if (PDEC > 0) {
        PRINTFMT <- substr(paste(ftype[PTYP], PWID,'.', PDEC, "          ", sep=""),1,10) 
      } else {
        PRINTFMT <- substr(paste(ftype[PTYP], PWID, "          ", sep=""),1,10)
      }
      # !!!BUG: 'ftype[[PTYP]]' replaced by 'ftype[PTYP]'. Reason: ftype is not a list but a vector


      # read write format code
      # WRITEFMT <- readBin(sav, integer())
      WDEC <- readBin(sav, integer(), size=1)	# decimal places
      WWID <- readBin(sav, integer(), size=1)	# column width
      WTYP <- readBin(sav, integer(), size=1)	# format type
      IGNORE <- readChar(sav, 1, useBytes=TRUE)		# ignore 4th byte, always 0

      # read varname
      VARNAME <- readChar(sav, 8, useBytes=TRUE)

      # read label length and label only if a label exists
      VARLABEL <- ""
		
      if (HASLABEL == 1) {

        # read label length
        LABELLEN <- readBin(sav, integer())

        # round label len up to nearest multiple of 4 bytes
        if (LABELLEN %% 4 != 0) {
          LABELLEN <- 4 * ((LABELLEN %/% 4)+1)
        }

        # read label
        VARLABEL <- readChar(sav, LABELLEN, useBytes=TRUE)
	
      }

      # read missing values only if present
      MISSING1 <- NA
      MISSING2 <- NA
      MISSING3 <- NA

      if (NMISSING != 0) {

        # read each missing value (double)
        # NMISSING negative means values are a range
        if (abs(NMISSING) >= 1) { 
          MISSING1 <- readBin(sav, double())
        }

        if (abs(NMISSING) >= 2) { 
          MISSING2 <- readBin(sav, double())
        }

        if (abs(NMISSING) >= 3) { 
          MISSING3 <- readBin(sav, double())
        }
		  }

      result <- NULL
      result <- c(result, VARNAME)
      result <- c(result, PRINTFMT)
      result <- c(result, VARLABEL)
      result <- c(result, NMISSING)
      result <- c(result, MISSING1)
      result <- c(result, MISSING2)
      result <- c(result, MISSING3)

      return(result)

		} else {     # if TYPECODE is -1, record is a continuation of a string var

    # read and ignore the next 24 bytes
    IGNORE <- readChar(sav, 24, useBytes=TRUE)
    return()

		}
	}


	# check file signature, then read & ignore rest of fixed portion of header
	if (readChar(sav, 4, useBytes=TRUE) != "$FL2") {
		print("This file does not appear to be an SPSS SAV file.")
		return()
	}
	IGNORE <- readChar(sav, 172, useBytes=TRUE)

  ## VERSI?N DE SPSS DEL ARCHIVO.
  version <- substr(IGNORE, 1, 60)
  version <- unlist(strsplit(version," "))
  version <- grep("^[0-9]+\\.[0-9]+\\.[0-9]+$", version, value=TRUE) ## XX.XX.XX
  version <- as.double(unlist(strsplit(version,"\\."))[1])
  if (length(version)==0) version<-11  # suposo que ?s inferior a la 12 (per exemple quan est? creada per l'STATTRANSFER no posa cap versi?)
  
  # process all variable definitions, building up the following vectors
  varname <- NULL
  printfmt <- NULL
  varlabel <- NULL
  nmiss <- NULL
  missing1 <- NULL
  missing2 <- NULL
  missing3 <- NULL
  longname <- NULL # data present for spss version >= 12...

	rectype <- readBin(sav, integer())
	while (rectype == 2) {
		v <- variable_record()
		if (length(v) != 0) {
			varname <- c(varname,v[1])
			printfmt <- c(printfmt,v[2])
			varlabel <- c(varlabel,v[3])
			nmiss <- c(nmiss, as.integer(v[4]))
			missing1 <- c(missing1, v[5])
			missing2 <- c(missing2, v[6])
			missing3 <- c(missing3, v[7])
		}
 		rectype <- readBin(sav, integer())
	}

  # per a les variables cadena AXX, si la llargada ?s molt gran posa A-XX, on XX (per exemple enlloc de posar A255 posa A-1, o enlloc de posar
  # A199 posa A-57. 
	index<-grep("-",printfmt)
	aux<-as.double(unlist(lapply(strsplit(printfmt[index],"-"),function(x) x[2])))
	printfmt[index]<-paste("A",256-aux,sep="")
	
	#cat("La versi? del SPSS ?s:",version,"\n")
	
  if (version>=12){

  	# >>>
  	#cat('rectype', rectype, '\n')
  	# check for a value label set / variable index pair (rectypes 3 & 4)
  	while (rectype==3) {
  		elemcount <- readBin(sav, integer())	# number of labels defined 
  		while (elemcount > 0) {
  			#cat(' 3:', elemcount)
  			elemcount <- elemcount - 1
  			IGNORE <- readChar(sav, 8, useBytes=TRUE)
  			elemsize <- (readBin(sav, integer(), size=1) %/% 8)
  			IGNORE <- readChar(sav, 7, useBytes=TRUE)
  			while (elemsize > 0) {	# may need to skip extra words if labelstring longer than 7
  				elemsize <- elemsize - 1
  				IGNORE <- readChar(sav, 8, useBytes=TRUE)
  			}
  		}
  		rectype <- readBin(sav, integer())
  		elemcount <- readBin(sav, integer())
  		if (rectype != 4) {
  			stop('\n\nEXPECTED RECORD TYPE 4 NOT FOUND.\n')
  		} else {
  			while (elemcount > 0) {
  				#cat(' 4:', elemcount)
  				elemcount <- elemcount - 1
  				IGNORE <- readChar(sav, 4, useBytes=TRUE)
  			}
  			rectype <- readBin(sav, integer())
  		}
  		#cat('\nNext rectype', rectype, '\n')
  	}

  	# Check for presence of Type 7 records.
  	# Type 7 records allow later versions of SPSS to write files containing
  	# dictionary information that earlier releases do not expect. These records
	  # consist of 4 integers followed by an array of data elements, the
  	# 4 integers provide (in this order): 
  	#  Record Type Code (7)
  	#  Subtype code
  	#  Data element length (eg. 1=char, 4=integer, 8=double, etc)
  	#  Number of elements of that length which follow
  	#  Data array of indicated length (meaning depending on Subtype)
  	#
  	# Specifically we look for a record of Type 7, SubType 13 (SPSS version >= 12).
  	# It contains a string of the form SHORTNAME=LongName<TAB> SHORTNAME=LongName<TAB> ...
  	# In other words the equivalent long variable names (allowing mixed case)
  	# associated with the short uppercase only names specified earlier (Type 2 recs)
  	# 
  	while (rectype == 7) {
  		subtype  <- readBin(sav, integer())
  		elemsize <- readBin(sav, integer())
  		elemcount<- readBin(sav, integer())

  		# save long var name info to vector 'longname', ie the text following an 
  		# "=" sign, up to but not including a TAB char. Note that we DO NOT save the 
  		# shortname part.
  		if (subtype == 13 && elemsize==1 ) { 
  			TEMP <- NULL
  			while (elemcount > 0) {
  				elemcount <- elemcount-1
  				ch <- readChar(sav, 1, useBytes=TRUE)
  				if (ch != "="  && ch != "\t") {
  					TEMP<- paste(TEMP,ch,sep="")
  				}
  				if (ch == "=") { 		# = sign indicates start of long name value
  					TEMP <- NULL	
  				}
  				if (ch == '\t') {			# Tab indicates end of long name
  					longname <- c(longname, TEMP)	#
  					TEMP <- NULL
  				}
    			}
    			longname <- c(longname, TEMP)
  		} else {
  			IGNORE <- readChar(sav, (elemsize*elemcount), useBytes=TRUE)
  		}
  		rectype <- readBin(sav, integer())
  	}

  } else longname <- varname # version <12.0
 
  #erase empty spaces in varname, longname and printfmt
  varname <- gsub(" ","",varname)
  printfmt <- gsub(" ","",printfmt)
  longname <- gsub(" ","",longname)
  	
  varlabel<-trim(varlabel)


	dict <- cbind(varname,printfmt,nmiss,missing1,missing2, missing3, varlabel, longname)
  dict <- apply(dict,2,as.character)

	close(sav)

	return(dict)
	
}
##############################################################################

