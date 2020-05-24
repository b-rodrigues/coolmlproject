library(workflows)
library(yardstick)
library(recipes)
library(tune)
library(dials)
library(parsnip)
library(readr)
library(drake)
library(dplyr)
library(coolmlproject)

plan <- drake_plan(

  datasets = get_data(),

  training_set = datasets$data_train,

  testing_set = datasets$data_test,

  training_splits = rsample::vfold_cv(training_set, v = 3),

  preprocessed = preprocess(training_set),

  boosted_trees_model = define_model(boost_tree,
                                     "xgboost",
                                     "classification",
                                     mtry = tune(),
                                     tree = tune(),
                                     tree_depth = tune()),

  boost_grid = boosted_trees_model %>%
    define_grid(predictor_data = select(training_set,
                                        -target),
                grid_max_entropy,
                size = 5),

  boost_wflow = define_wflow(preprocessed,
                             boosted_trees_model),

  tuned_boosted_trees = tune_grid(boost_wflow,
                                  training_splits,
                                  boost_grid),

  best_boosted_trees_hyperparams = select_best(tuned_boosted_trees, "roc_auc") %>%
                                                               as.list(),

  best_boosted_trees_model = define_model(boost_tree,
                                    "xgboost",
                                    "classification",
                                    mtry = best_boosted_trees_hyperparams$mtry,
                                    trees = best_boosted_trees_hyperparams$trees,
                                    tree_depth = best_boosted_trees_hyperparams$tree_depth),

  best_boost_wflow = define_wflow(preprocessed,
                             best_boosted_trees_model),

  fit_boosted_trees = fit(best_boost_wflow, data = training_set),

  show_lvl = show_lvl(fit_boosted_trees),

  boost_predictions_prob = predict(fit_boosted_trees, testing_set, "prob"),

  boost_predictions_class = predict(fit_boosted_trees, testing_set, "class"),

  testing_set_and_preds = bind_cols(
    list(
      testing_set,
      boost_predictions_prob,
      boost_predictions_class
    )),

  conf_mat_boost = conf_mat(testing_set_and_preds, truth = target, estimate = .pred_class),

  roc_curve_boost = roc_curve(testing_set_and_preds, truth = target, `.pred_<=50K`),

  roc_auc_boost = roc_auc(testing_set_and_preds, truth = target, `.pred_<=50K`),

  report = rmarkdown::render(knitr_in("full_path_to/inst/report.Rmd"),
                             output_file = file_out("full_path_to/inst/report.docx"))


)


make(plan)
