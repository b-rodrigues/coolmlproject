#' Preprocess the data for training
#'
#' @param training_set The training data
#' @return 
#' @importFrom recipes recipe step_dummy all_predictors
#' @export
preprocess <- function(training_set){
  recipes::recipe(target ~ ., data = training_set) %>%
   recipes::step_dummy(recipes::all_predictors())
}
