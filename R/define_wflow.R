#' Define the workflow
#'
#' @param recipe A trained recipe
#' @param model A model specification
#' @return 
#' @import workflows
#' @export
define_wflow <- function(recipe, model, ...){

  workflows::workflow() %>%
    workflows::add_recipe(recipe) %>%
    workflows::add_model(model)

}
