# install package readxl to read microsoft excel files
install.packages("readxl")
library(readxl)
library(readr)

# read murders.csv file and store in dat

dat <- read_csv("data/murders.csv")

# read murder.csv file using r base function and store in dat2

dat2 <- read.csv("data/murders.csv")


# note the classes of dat and dat2
class(dat)

class(dat2)

# note that dat is a tibble whereas dat2 is a data frame

# read file directly from the internet using read.csv("url") or download file using 
# download.file("url", "filename.ext") then read the file

