#' Preprocess the data for training
#'
#' @param training_set The training data
#' @return 
#' @importFrom recipes recipe step_dummy all_predictors
#' @export
preprocess <- function(training_set){
  recipe(target ~ ., data = training_set) %>%
    step_dummy(all_predictors())
}
