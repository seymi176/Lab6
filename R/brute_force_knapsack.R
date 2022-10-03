data(knapsack_objects)

#' Knapsack brute force search
#'
#' @param x A data frame containing values and weights of items
#' @param W The knapsack's capacity
#' @param parallel Parallelize brute force search
#'
#' @return A data frame of two elements: maximum value and selected elements.
#' @export brute_force_knapsack

brute_force_knapsack <- function(x,W,parallel=FALSE) {
  # Check input
  if (!is.data.frame(x)) {stop("x must be a data frame")}
  if (any(x<0 , na.rm = TRUE)) {stop("x items must be positive")}
  if (!(length(x)==2)) {stop("x must have two variables")}
  if(!(all(names(x)==c("w","v")))) {stop("x variable names must be u and v")}
  if (!(W>0 && length(W)==1 && is.numeric(W))) {stop("W must be a positive number")}
  
  i <- 1
  tempWeight <- 0
  tempValue  <- 0
  finalWeight <- 0
  finalValue  <- 0
  elements <- c()
  n<- dim(x[1])[1]
  sizeOfLoop <- 2^n

  if(parallel==TRUE){
    cores <- parallel::detectCores()
    cl <- parallel::makeCluster(cores, type = "PSOCK")
    
    parallel::clusterExport(cl, varlist=c("x","W","n","elements","finalValue","tempValue", "tempWeight","finalWeight", "sizeOfLoop"), envir=environment())
    # parallel::clusterEvalQ(cl, library(utils))
    values<-parallel::parLapply(cl, 1:sizeOfLoop, function(i, x,W) {
      while(i < sizeOfLoop){
        comb=which(intToBits(i)==1)
        tempWeight <- sum(x$w[comb])
        tempValue <- sum(x$v[comb])
        
        if(tempWeight <= W && tempValue > finalValue) {
          finalValue  <- tempValue
          elements <- comb
        }
        i <- i + 1
      }
      df <- list(round(finalValue), elements)
      names(df) <- c("value", "elements")
      return(df)
    }, x, W )
    value<-values[[1]]["value"]
    elements<-values[[1]]["elements"]

    df <- list(value, elements)
    names(df) <- c("value", "elements")
    return(df)
    parallel::stopCluster(cl)

    return(c(value,elements))
    parallel::stopCluster(cl)
    
  }else {
    while(i < sizeOfLoop){
      comb=which(intToBits(i)==1)
      tempWeight <- sum(x$w[comb])
      tempValue <- sum(x$v[comb])
      
      if(tempWeight <= W && tempValue >= finalValue) {
        finalValue  <- tempValue
        elements <- comb
      }
      i <- i + 1
    }
    df <- list(round(finalValue), elements)
    names(df) <- c("value", "elements")
    return(df)
  }
}
# brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500, parallel=FALSE)
# brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500, parallel=TRUE)
  
