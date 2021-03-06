##----------------------------------------------------------------------------------------------------------##
## Linear interpolation of data. 
##----------------------------------------------------------------------------------------------------------##
interpData <- function(data_1, x)
{
  counter <- t(as.matrix(1:length(data_1[,1])))
  result <- apply(counter, 2, lin_int <- function(i)
                  {
                    y <- coredata(as.array((data_1[i,])))
                    return(t(spline(x = x, y = y, n = 40, xmin = 0.25, xmax = 10)$y))
                  })
  return(result)
}

interpolate <- function(data_1)
{
  maturities <- strtoi(str_sub(colnames(data_1), 2, -1))/12
  data_interp <- t(interpData(data_1, maturities))
  col_names <- c(3, 6, 9, 12, 15, 18, 21, 24, 30, 36, 48, 60, 72, 84, 96, 108, 120)
  data_interp <- data_interp[, c(1, 2, 3, 4, 5, 6, 7, 8, 10, 12, 16, 20, 24, 28, 32, 36, 40)]
  colnames(data_interp) <- col_names
  data_interp <- as.zoo(data_interp)
  index(data_interp) <- index(data_1)
  return(data_interp)
}
##----------------------------------------------------------------------------------------------------------##
##----------------------------------------------------------------------------------------------------------##