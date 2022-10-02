suppressWarnings(RNGversion(min(as.character(getRversion()),"3.5.3")))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <- data.frame(w=sample(1:4000, size = n, replace = TRUE), v=runif(n = n, 0, 10000))


#' Dynamic programming for knapsach probrem
#'
#' @param x A data frame containing values and weights of items
#' @param W The knapsack's capacity
#'
#' @return Maximum value and selected elements.
#' @export knapsack_dynamic
#'
#' @examples
knapsack_dynamic <- function(x, W){
  if (!is.data.frame(x)) {stop("x must be a data frame")}
  if (any(x<0 , na.rm = TRUE)) {stop("x items must be positive")}
  if (!(length(x)==2)) {stop("x must have two variables")}
  if(!(all(names(x)==c("w","v")))) {stop("x variable names must be u and v")}
  if (!(W>0 && length(W)==1 && is.numeric(W))) {stop("W must be a positive number")}
  
  m <- matrix(0, length(x$v)+1, W+1)
  
  for (i in 1:length(x$v)){
    for (j in 1:W){
      
      if(x$w[i] > j){
        m[i+1, j+1] <- m[i, j+1]
      } else{
        m[i+1, j+1] <- max(m[i, j+1], (x$v[i] + m[i, abs(j+1-x$w[i])]))
      }
    }
  }

#Looking for the selected elements in the sum
  j <- j+1
  i <- which.max(m[,j])
  k <- 1
  elements <- list()
  elements[k] <- i-1
  
  while (m[i,j]!=0 && j!=1 && i!=0) {
    k <- k+1
    j <- j-x$w[i-1]
    i <- which(m[,j]==m[i-1,j])[1]
    elements[k] <- i-1
  }

  values<-list(value=round(m[length(x$v)+1,W+1]),elements=elements[elements>0])   
  
  return(values)
}