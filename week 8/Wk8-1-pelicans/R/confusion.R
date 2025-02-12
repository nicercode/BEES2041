#' Evaluate model predictive skill on training and testing data
#' 
#' This function takes a fitted model and evaluates its predictive performance on 
#' training and testing datasets. It returns a confusion matrix and the accuracy
#' of the model on the training and testing data.
#' 
#' @param fit Fitted model object
#' @param data_train Training dataset as a dataframe
#' @param data_test Testing dataset as a dataframe
#' @param y Name of the response variable in the datasets (default: "is_pelican")
#' @param digits Number of digits to use in printing the results (default: 7)
#' 
#' @return A confusion matrix and the accuracy of the model on training and testing datasets.
#' 
#' @examples
#' library(ranger)
#' data(iris)
#' set.seed(123)
#' train_idx <- sample(nrow(iris), 0.8 * nrow(iris))
#' data_train <- iris[train_idx,]
#' data_test <- iris[-train_idx,]
#' fit <- ranger(Species ~ ., data = data_train)
#' evaluate_model(fit, data_train, data_test)
#'
#' @importFrom ranger ranger
#' @importFrom magrittr %>%
#' 
#' @export
evaluate_model <- function(fit, data_train, data_test, y = "is_pelican", digits = getOption("digits")) {
  
  # customise prediction function for different methods
  if("ranger" %in% class(fit))
    pred <-  function(fit, data) predict(fit, data=data)$predictions
  else if("lm" %in% class(fit))
    pred <-  function(fit, data) {
      y_hat <- predict(fit, newdata=data, type = "response")
      ifelse(y_hat > 0.5, "pelican", "background") %>% as.factor()
    }
  
  pred_train <- data_train %>% 
    mutate(pred =  pred(fit, data = data_train))
  
  pred_test <- data_test %>% 
    mutate(pred =  pred(fit, data = data_test))
  
  confusion_matrix <- function (actual, predicted) 
  {
    
    cat("\n  Confusion Matrix\n")
    out <- table(predicted, actual)
    
    print(out)
    
    out_df <- out %>% as.data.frame()
    N = out_df$Freq %>% sum()
    correct = out_df %>% dplyr::filter(actual==predicted) %>% pluck("Freq") %>% sum()
    Accuracy = correct/N
    cat("\n  N = ", N, ", Accuracy = ", Accuracy, sep="")
  }
  
  cat(crayon::black("\nEvaluating model predictive skill"))
  
  cat(crayon::green("\nResults in TRAINING data"))
  
  confusion_matrix(pred_train[[y]], pred_train$pred)
  
  message(crayon::red("\n\nResults in TESTING data"))
  confusion_matrix(pred_test[[y]], pred_test$pred)
}
