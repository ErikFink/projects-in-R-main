# Main R script that sources all subsequent R scripts
library(tidyverse)
library(here)
library(lubridate)

#Set Working Directory
setwd("C:/Users/efink/My Tresors/Erik's tresor/R_course/projects/projects-in-R-main")

#Source Scripts
source(here("tidyverse_scripts.R")) # source() reads R code from a file
