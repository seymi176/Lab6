# data("knapsack_objects")
#' Brute force search in knapsack problem
#' 
#' @param x A dataframe containing the values (v) and the weights (w) of a number of items to put in the knapsack.
#' @param W The knapsack size.
#' @param parallel An optional logical variable (the default is FALSE). If is TRUE the function should parallelize over the detected cores.
#' @return A list of two elements: a positive number with the maximum knapsack \code{value} and a vector of all the \code{elements} in the knapsack size.
#' @examples
#' set.seed(42)
#' n <- 2000
#' knapsack_objects <-data.frame(w=sample(1:4000, size = n, replace = TRUE),v=runif(n = n, 0, 10000))
#' brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)
#'@export brute_force_knapsack
#'@importFrom utils combn

brute_force_knapsack<-function(x,W,parallel=FALSE){
  if (!is.data.frame(x)) {stop("x must be a data frame")}
  if (any(x<0 , na.rm = TRUE)) {stop("x items must be positive")}
  if (!(length(x)==2)) {stop("x must have two variables")}
  if(!(all(names(x)==c("w","v")))) {stop("x variable names must be u and v")}
  if (!(W>0 && length(W)==1 && is.numeric(W))) {stop("W must be a positive number")}
  
  maxvalue<-0
  value<-0
  n<-dim(x)[1]
  elements<-length(n)
  
  if(parallel==TRUE){
    cores <- parallel::detectCores()
    cl <- parallel::makeCluster(cores, type = "PSOCK")
    
    parallel::clusterExport(cl, varlist=c("x","W","n","elements","maxvalue","value"), envir=environment())
    parallel::clusterEvalQ(cl, library(utils))
    
    values<-parallel::parLapply(cl, 1:n, function(i, x,W) {
      
      comb<-utils::combn(n,i) #all possible combination of i from 1 to n
      j<-1
      
      while(j<=ncol(comb)){ 
        if(sum(x$w[comb[,j]])<=W){
          value<-sum(x$v[comb[,j]])
          if(maxvalue<value){
            elements<-comb[,j] #save elements of that combination
            maxvalue<-value #save the max value you found
          }
        }
        j<-j+1
      }
      
      return(list(value=round(maxvalue),elements=elements))
      
    }, x, W )
    
    i=1
    while(values[[i]]["value"]!=0){
      value<-values[[i]]["value"]
      elements<-values[[i]]["elements"]
      i<-i+1
    }
    return(c(value,elements))
    parallel::stopCluster(cl)
    
  }else{ 
    
    lapply(1:n, function(i){
      comb<-combn(n,i) #all possible combination of i from 1 to n
      j<-1
      while(j<=ncol(comb)){ 
        if(sum(x$w[comb[,j]])<=W){
          value<-sum(x$v[comb[,j]])
          if(maxvalue<value){
            elements<<-comb[,j] #save elements of that combination
            maxvalue<<-value #save the max value you found
          }
        }
        j<-j+1
      }
    })
    
    value<-round(maxvalue)
    values<-list(value=value,elements=elements)
    return(values)
  }
}

# brute_force_knapsack(x = knapsack_objects[1:20,], W = 3500)
# brute_force_knapsack(x = knapsack_objects[1:20,], W = 3500,parallel=TRUE)