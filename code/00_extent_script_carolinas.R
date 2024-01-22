###################################################
### 0. Spatial extent calculations -- Carolinas ###
###################################################

# Clear environment
rm(list = ls())

# Calculate start time of code (determine how long it takes to complete all code)
start <- Sys.time()

#####################################
#####################################

# Load packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(docxtractr,
               dplyr,
               elsa,
               fasterize,
               fs,
               ggplot2,
               janitor,
               ncf,
               paletteer,
               pdftools,
               plyr,
               purrr,
               raster,
               RColorBrewer,
               reshape2,
               rgdal,
               rgeoda,
               rgeos,
               rmapshaper,
               rnaturalearth, # use devtools::install_github("ropenscilabs/rnaturalearth") if packages does not install properly
               RSelenium,
               sf,
               shadowr,
               sp,
               stringr,
               terra, # is replacing the raster package
               tidyr,
               tidyverse)

#####################################
#####################################

# set directories
## designate geodatabase
carolinas_gdb <- "data/Carolinas_20240117.gdb/Carolinas.gdb"

## export table directory
export_dir <- "data"

#####################################

# inspect
## top 10 layer names
sf::st_layers(dsn = carolinas_gdb,
              do_count = T)[[1]][1:10]

## all layers
### ***Note: if not all rows are printed (and you see something like: 
###          "reached 'max' / getOption("max.print") -- omitted 495 rows"
###          then type into console options(max.print = 2850). This should
###          print out all results 575 (rows) * 5 (fields) = 2875
sf::st_layers(dsn = carolinas_gdb,
              do_count = T)

## geometry type to identify which ones are vectors
vector <- which(!is.na(sf::st_layers(dsn = carolinas_gdb,
                                     do_count = T)$geomtype == "NA"))

### alternative to find rasters use which(is.na(sf::st_layers(dsn = carolinas_gdb, do_count = T)$geomtype == "NA"))

## see length of data layers (575 data layers)
length(sf::st_layers(dsn = carolinas_gdb,
                     do_count = T)[[1]])

## see length of vector data layers (521 data layers)
length(vector)

#####################################
#####################################

# parameters
# set the coordinate reference system that data should become (WGS84: https://epsg.io/4326)
crs <- "EPSG:4326"

# create reference table
table <- data.frame(dataset = character(),
                    xmin = numeric(),
                    xmax = numeric(),
                    ymin = numeric(),
                    ymax = numeric())

#####################################
#####################################

### Warning, skip 381, 386, 514, 518 -- AIS data take too long to run

# loop through all layers
for(i in 1:520){ # use length(sf::st_layers(dsn = carolinas_gdb, do_count = T)[[1]]) if all data are vector data
  start2 <- Sys.time()
  
  # i <- 1
  
  # skip analysis when i is equal to 381, 386, 514, or 518
  if((i == 381 || i == 386 || i == 514 || i == 518)){
    # print message saying why skipped
    print(paste("Skip interation", i, "for it cannot get completed due to either: (1) takes too much memory or (2) has no spatial extent"), sep = "/")
    # go to next iteration
    next
  }
  
  # run analysis when i is not equal to 381, 386, 514, or 518
  if(!(i == 381 || i == 386 || i == 514 || i == 518)){
    data_name <- sf::st_layers(dsn = carolinas_gdb,
                               do_count = T)[[1]][i]
    
    data_set <- sf::st_read(dsn = carolinas_gdb,
                            layer = sf::st_layers(carolinas_gdb)[[1]][i]) %>%
      sf::st_transform(x = .,
                       crs = crs)
    
    assign(data_name, data_set)
    
    # retreive the spatial extent values
    xmin <- terra::ext(data_set)[1]
    xmax <- terra::ext(data_set)[2]
    ymin <- terra::ext(data_set)[3]
    ymax <- terra::ext(data_set)[4]
    
    # print the spatial extent
    print(terra::ext(data_set))
    
    # create a dataframe of one row with the dataset name and spatial extent information
    result_table <- data.frame(
      data_name,
      xmin,
      xmax,
      ymin,
      ymax)
    
    # bind the resulting table row to the original table
    table <- rbind(table, result_table)
    
    # remove the current data set
    rm(data_set)
    
    # print how long it takes to calculate
    print(paste("Iteration", i, "of", length(vector), "takes", Sys.time() - start2, units(Sys.time() - start2), "to complete creating and adding", data_name, "data to dataframe", sep = " "))
  }
}

#####################################
#####################################

# make the row names be the row number
rownames(table) <- 1:nrow(table)

#####################################
#####################################

# export table as csv
write.csv(x = table, file = paste(export_dir, "carolinas_data_extent.csv", sep = "/"))

#####################################
#####################################

# calculate end time and print time difference
print(Sys.time() - start) # print how long it takes to calculate
