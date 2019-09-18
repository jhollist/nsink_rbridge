tool_exec <- function(in_params, out_params){
  browser()
  huc <- in_params$huc
  epsg <- in_params$epsg
  data <- in_params$data_dir
  output <- in_params$output_dir
  prepped_data <- nsink::nsink_prep_data(huc,epsg,data)
  sf::st_write(prepped_data$streams, paste0(output,"/streams.shp"))
  sf::st_write(prepped_data$streams, paste0(output,"/lakes.shp"))
  raster::writeRaster(prepped_data$fdr, "fdr.tif")
  raster::writeRaster(prepped_data$impervious, "impervious.tif")
  sf::st_write(prepped_data$ssurgo, paste0(output,"/ssurgo.shp"))
  readr::write_csv(prepped_data$q, paste0(output,"/q.csv"))
  readr::write_csv(prepped_data$tot, paste0(output,"/tot.csv"))
  readr::write_csv(prepped_data$lakemorpho, 
                   paste0(output,"/lakemorpho.csv"))
  sf::st_write(prepped_data$huc, paste0(output,"/huc.shp"))
  raster::writeRaster(prepped_data$raster_template, paste0(output,"raster_template.tif"))
}

# "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"

#in_params <- list(huc = nsink_get_huc_id("Niantic")$huc_12,epsg = 2234, data_dir = "../nsink/nsink_data/", output_dir = "test")

#tool_exec(in_params, "x")
