RNGversion(min(as.character(getRversion()),"3.5.3"))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <- data.frame(w=sample(1:4000, size = n, replace = TRUE), v=runif(n = n, 0, 10000))

brute_force_knapsack <- function(x, W){
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
  element <- c()
  sizeOfLoop <- 2^(dim(x[1])[1])
  
  while(i < sizeOfLoop){
    
    tempWeight <- sum(x$w[as.logical(intToBits(i))])
    tempValue  <- sum(x$v[as.logical(intToBits(i))])
    
    if(tempWeight <= W & tempValue >= finalValue){
      
      finalValue  <- tempValue
      finalWeight <- tempWeight
      element <- which(intToBits(i)==1)
    }
    
    i <- i + 1
  }
  
  df <- list(finalValue, element)
  names(df) <- c("value", "elements")
  return(df)
}