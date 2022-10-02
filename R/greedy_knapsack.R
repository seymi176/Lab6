
RNGversion(min(as.character(getRversion()),"3.5.3"))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )


greedy_knapsack <- function(x, W){
  
  valueWeigthRation  <- x$v / x$w
  positionOfElements <- c(1:length(x$v))
  finalDataFrame     <- cbind(x, valueWeigthRation,  positionOfElements)
  sortedDataFrame    <- finalDataFrame[order(finalDataFrame[,3], decreasing = T),]
  
  i <- 1
  tempValue   <- 0
  tempWeight  <- 0
  checkWeight <- 0
  elementList <- c()
  
  while(i < length(x$v)){
    
    checkWeight <- tempWeight + sortedDataFrame[i,1]
    if (checkWeight <= W) {
      tempWeight <- sortedDataFrame[i,1] + tempWeight
      tempValue  <- sortedDataFrame[i,2] + tempValue
      elementList <- append(elementList, sortedDataFrame[i,4])
    }
    
    checkWeight <- 0
    i <- i + 1
  }
  
  df <- list(tempWeight, tempValue, elementList)
  names(df) <- c("weight", "value", "elements")
  return(df)
  
}

