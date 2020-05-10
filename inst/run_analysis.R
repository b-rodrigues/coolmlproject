library(coolmlproject)
library(dplyr)
library(drake)


plan <- drake_plan(


  datasets = get_data(),

  training_set = datasets$data_train,

  testing_set = datasets$data_test,

  training_splits = rsample::vfold_cv(training_set, v = 10),
  
  preprocess = preprocess(training_set),

  boosted_trees_model = define_model(boost_tree, "xgboost", "classification",
                                     mtry = tune(),
                                     tree = tune(),
                                     tree_depth = tune()),

  boost_grid = boosted_trees_model %>%
    define_grid(predictor_data = select(training_set, -target), grid_max_entropy, size = 5),

  boost_wflow = define_wflow(preprocess, boosted_trees_model),

  tuned_boosted_trees = tune_grid(boost_wflow,
                                  training_splits,
                                  boost_grid)


)


make(plan)
