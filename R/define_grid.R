#' Define the grid
#'
#' @param model_spec A model specification
#' @param grid_size The size of the grid
#' @param finalize Should the parameters be finalized (mtry for tree based model for instance)
#' @return 
#' @import tune dials
#' @export
define_grid <- function(model_spec, predictor_data, grid, ...){

  model %>%
    parameters() %>%
    finalize(x = predictor_data) %>%
    grid(...)

}
