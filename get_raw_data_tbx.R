tool_exec <- function(in_params, out_params){
  huc <- in_params$huc
  output_folder <- in_params$output_folder
  result_list <- nsink::nsink_get_data(huc, output_folder)
  print(result_list)
}