#' Evaluate a Fitted Model on Training and Testing Data
#'
#' This function evaluates the performance of a fitted model on a training dataset
#' and a testing dataset. It calculates the R2 and RMSE metrics of the model, and 
#' creates a scatterplot of the predicted versus observed values of Coral.
#'
#' @param fit The fitted model to evaluate
#' @param data_train The training dataset used to fit the model
#' @param data_test The testing dataset used to evaluate the model
#' @param ... Additional arguments to be passed to the prediction function
#'
#' @details The function customizes the prediction function for different methods 
#' of fitting models. The predicted values of Coral are added to data_train and data_test. 
#' data_train and data_test are combined into data_pred for plotting. The function calculates 
#' the R2 and RMSE metrics of the model on both the training and testing datasets. A scatterplot 
#' of the predicted versus observed values of Coral is created for both the training and testing 
#' datasets. A text label displaying the R2 and RMSE metrics is added to the scatterplot.
#'
#' @return A scatterplot of the predicted versus observed values of Coral, along with text 
#' labels displaying the R2 and RMSE metrics.
#'
#' @examples
#' library(ranger)
#' library(dplyr)
#' library(ggplot2)
#' 
#' # load data
#' data <- read.csv("data.csv")
#' 
#' # split data into training and testing sets
#' set.seed(123)
#' train_idx <- sample(nrow(data), nrow(data)*0.7)
#' train <- data[train_idx,]
#' test <- data[-train_idx,]
#' 
#' # fit model
#' fit <- ranger(Coral ~ ., data=train)
#' 
#' # evaluate model
#' evaluate_my_models(fit, train, test)
#'
#' @export
evaluate_my_models <- function(fit, data_train, data_test, ...) {
  
  # customise prediction function for different methods
  if("ranger" %in% class(fit))
    pred <-  function(fit, data) predict(fit, data=data)$prediction
  else if("lm" %in% class(fit))
    pred <-  function(fit, data) predict(fit, newdata=data)
  
  # add within sample predictions
  data_train <- data_train %>% mutate(group = "training",
                                      predicted = pred(fit,data_train))
  
  # add out of sample predictions
  data_test <- data_test %>%  mutate(group = "testing",
                                     predicted =  pred(fit, data_test))
  
  # comnbine for plotting
  data_pred <-  rbind(data_train, data_test)  %>%
    mutate(
      group = factor(group, levels = c("training", "testing"))
    )
  
  # Calculate stats on model fit
  model_stats <- 
    data_pred %>% 
    group_by(group) %>% 
    summarise(
      # Caluclate R2
      r2 = cor(Coral, predicted)^2,
      #Calculate RMSE
      RMSE = sqrt(sum((Coral - predicted)^2)/n())
    ) %>% 
    ungroup() %>%
    # for plotting
    mutate(
      # location to add on plot
      x = 0, y=100,
      # label to show
      stats = paste0("RMSE = ", format(RMSE, digits=2), ", R2 =", format(r2, digits=2))
    )
  
  # Make a plot
  data_pred %>%
    ggplot(aes(Coral, predicted)) +
    # raw data
    geom_point(col="darkgrey") +
    # 1:1
    geom_abline(intercept = 1, slope=1, linetype="dashed") +
    # add stats
    geom_text(data = model_stats, aes(x, y, label = stats), hjust=0, col="red") +
    labs(x="Observed Y", y="Predicted Y") +
    ylim(c(0,100)) + xlim(c(0, 100)) +
    facet_wrap(~group) + theme_classic()
}
