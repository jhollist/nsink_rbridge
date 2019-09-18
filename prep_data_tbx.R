tool_exec <- function(in_params, out_params){
  huc <- in_params$huc
  prj <- in_params$projection
  data <- in_params$data_dir
  output_folder <- out_params$output
  prepped_data <- nsink::nsink_prep_data(huc,prj,data)
  sf::st_write(prepped_data$streams, paste0(output_folder,"/streams.shp"))
  sf::st_write(prepped_data$streams, paste0(output_folder,"/lakes.shp"))
  raster::writeRaster(prepped_data$fdr, "fdr.tif")
  raster::writeRaster(prepped_data$impervious, "impervious.tif")
  sf::st_write(prepped_data$ssurgo, paste0(output_folder,"/ssurgo.shp"))
  readr::write_csv(prepped_data$q, paste0(output_folder,"/q.csv"))
  readr::write_csv(prepped_data$tot, paste0(output_folder,"/tot.csv"))
  readr::write_csv(prepped_data$lakemorpho, 
                   paste0(output_folder,"/lakemorpho.csv"))
  sf::st_write(prepped_data$huc, paste0(output_folder,"/huc.shp"))
  raster::writeRaster(prepped_data$raster_template, "raster_template.tif")
}