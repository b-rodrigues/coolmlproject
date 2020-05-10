#' Define the workflow
#'
#' @param recipe A trained recipe
#' @param model A model specification
#' @return 
#' @import workflows
#' @export
define_wflow <- function(recipe, model, ...){

  workflow() %>%
    add_recipe(recipe) %>%
    add_model(model)

}
