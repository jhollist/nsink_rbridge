tool_exec <- fuoutputnction(in_params, out_params){
  huc <- in_params$huc
  epsg <- in_params$epsg
  data <- in_params$data_dir
  output <- out_params$output_dir
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