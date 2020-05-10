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
    set_engine(engine) %>%
    set_mode(mode)

}
