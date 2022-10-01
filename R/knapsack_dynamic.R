
RNGversion(min(as.character(getRversion()),"3.5.3"))
set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )



knapsack_dynamic <- function(x, W){
  
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
  
  return(m[length(x$v)+1, W+1])
}