suppressWarnings(RNGversion(min(as.character(getRversion()),"3.5.3")))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <- data.frame(w=sample(1:4000, size = n, replace = TRUE), v=runif(n = n, 0, 10000))

greedy_knapsack <- function(x, W) {
# Input Check
  if (!is.data.frame(x)) {stop("x must be a data frame")}
  if (any(x<0 , na.rm = TRUE)) {stop("x items must be positive")}
  if (!(length(x)==2)) {stop("x must have two variables")}
  if(!(all(names(x)==c("w","v")))) {stop("x variable names must be u and v")}
  if (!(W>0 && length(W)==1 && is.numeric(W))) {stop("W must be a positive number")}
  
  x$ValPerWei <- x$v / x$w
  x$Position <- c(1:length(x$v))
  x <- x[order(x[,3], decreasing = T),]
  row.names(x) <- c(1:length(x$v))
  
  i <- 1
  tempValue   <- 0
  tempWeight  <- 0
  checkWeight <- 0
  elementList <- c()
  
  
  while(i < length(x$v)){
    
    checkWeight <- tempWeight + x[i,1]
    if (checkWeight <= W) {
      tempWeight <- x[i,1] + tempWeight
      tempValue  <- x[i,2] + tempValue
      elementList <- append(elementList, x[i,4])
    } else {
      break
      tempValue <- sum( x[1,2]: x[i,2])
    }
    i <- i + 1
  }
  
  df <- list(round(tempValue), elementList)
  names(df) <- c("value", "elements")
  return(df)
}