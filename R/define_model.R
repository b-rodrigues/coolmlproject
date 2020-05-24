#' Define the model
#'
#' @param model The model to be fit
#' @param engine The underlying engine
#' @param mode Classification or regression?
#' @return 
#' @import parsnip
#' @export
define_model <- function(model, engine, mode, ...){

  model(...) %>%
    parsnip::set_engine(engine) %>%
    parsnip::set_mode(mode)

}
