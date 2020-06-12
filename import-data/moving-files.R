# view your working directory
getwd()

# set working directory to learn-data-wrangling/data

setwd("data")


# view your new working directory
getwd()

# extdata of dslabs package contains raw data files. Check the path of extdata and store it in 
# path

path <- system.file("extdata", package = "dslabs")

# list the files in extdata folder

list.files(path)

# generate full path to the file murders.csv contained in extdata folder

fullpath <- file.path(path, "murders.csv")

# copy file murders.csv to your working directory

file.copy(fullpath, getwd())

# check if the file now exists in the working directory

file.exists("murders.csv")

# another way to check if file exists in the working directory

list.files()