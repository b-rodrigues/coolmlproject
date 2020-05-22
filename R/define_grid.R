#' Define the grid
#'
#' @param model_spec A model specification
#' @param predictor_data The predictor data used to finalize the grid
#' @param grid_type The type of grid
#' @return 
#' @import tune dials
#' @export
define_grid <- function(model_spec, predictor_data, grid_type, ...){

  model_spec %>%
    tune::parameters() %>%
    dials::finalize(x = predictor_data) %>%
    grid_type(...)

}
