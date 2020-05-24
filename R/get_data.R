#' Get the data from the UCI repository
#'
#' @return A list with the training set (data_train) and the testing set (data_test)
#' @import dplyr
#' @importFrom readr read_csv
#' @importFrom stringr str_remove_all
#' @export
get_data <- function(){

  n <- 100

  data_train <- read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data",
                         col_names = FALSE) %>%
    sample_n(n)

  cat("Sampling ", n, "columns\n")


  column_names <- c("age",
                    "workclass",
                    "fnlwgt",
                    "education",
                    "education_num",
                    "marital",
                    "occupation",
                    "relationship",
                    "race",
                    "sex",
                    "capital_gain",
                    "capital_loss",
                    "hours_week",
                    "native_country",
                    "target")

  colnames(data_train) <- column_names

  data_train <- data_train %>%
    mutate(target = as.factor(target))

  data_test <- read_csv("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test", skip = 1,
                        col_names = FALSE)

  colnames(data_test) <- column_names

  data_test <- data_test %>%
    mutate(target = str_remove_all(target, "\\.")) %>%  
    mutate(target = as.factor(target)) %>%
    sample_n(n)
 

  list("data_train" = data_train,
       "data_test" = data_test)

}
