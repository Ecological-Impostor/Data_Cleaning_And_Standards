# Project: Cleaning Data and Standards- Assignment for CIEE's LDP
# Author: Amanda Gregoire
# Purpose: Learning how to create clean, reproducible data. This project uses
#          data from the Turkey Lakes Watershed.

# ---- Notes -----------------------------------------------------------

# I used renv::init() # on-time set up when creating the project
# this script uses renv to keep track of package versions, ensuring that 
# the script can be run in the future

# to resotre all package versions use renv::restore() before running script.

# ---- Packages --------------------------------------------------------

# install any of the missing packages using the line below.
# install.packages(c("assertr","stringdist","tidyverse","GGally","skimr"))
install.packages("skimr")
# load in the packages necessary to run the script
library(assertr)
library(stringdist) 
library(tidyverse)
library(GGally)
library(skimr)

# ---- Read & Initial Exploration ---------------------------------------------

# read in the raw data files 

chl_a_data <- readr::read_csv("chl-a-samples-messy.csv")
stations_data <- readr::read_csv("stations-messy.csv")
waterbodies_data <- readr::read_csv("waterbodies-messy.csv")

# initial exploration of the data

#ch-a-samples dataset
dim(chl_a_data) # 1578 rows, 15 variables (columns)
head(chl_a_data,20) # of note: date is labelled as chr, not date
# subsample_replicate all shows as NA
# sample_volume_filtered_ml set as chr, should be dbl
# absorbance_663nm set as chr, should be dbl
view(chl_a_data) # I would like to fully explore the dataset to verify NAs and
# the format that was used for date
# view() lets me manually inspect the dataset in a seperate tab
# date is organized as YYYY-MM-DD
# NAs are blank cells, not trouble reading file
skimr::skim(chl_a_data) # summarize the dataset
# there are some suspiciously low and high values that
# will need to be looked into.
# Of note:
# negative value in extract_volume_ml --> volume != negative
# p100 = 0.205 for absorbance_750nm when p75 = 0.003
# p100 = 0.757 for absorbance_645nm when p75 = 0.01
# p100 = 0.375 for absorbance_630nm when p75 = 0.008
# p100 = 70.7 and 391 for chl_a_16ed and ch_a_20ed, respectively,
# while p75 for both ~ 4.0

#stations dataset
dim(stations_data) # 97 rows, 6 variables (columns)
head(stations_data,10) # some positive values in longitude, should all be neg
# should ensure all latitudes are positive too
summary(stations_data) # class all correct
# min latitude = -83.96, lat and long might have been switched.
# should also check for typos and case sensitivity.

# waterbodies dataset 
dim(waterbodies_data) # 87 rows, 2 variables (columns)
head(waterbodies_data, 10) # class good, all looks good
# should check for possible case issues and typos
summary(waterbodies_data) # lengths match, all looks good.
