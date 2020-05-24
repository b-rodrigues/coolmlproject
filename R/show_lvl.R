#' Print the levels of the target variable
#' @param model_fit A trained workflow 
#'
#' @return NULL
#' @export
show_lvl <- function(model_fit){
  cat("Levels of the target variable:", model_fit$fit$fit$lvl, "\n")
}
