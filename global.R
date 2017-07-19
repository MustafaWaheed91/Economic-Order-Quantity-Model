source("loadPackages.R")
source("linechart.R")
# Using the parameters above create the data frame which will be plotted
createFrame <- function(D = 0,h = 0,A = 0,c = 0, Q =0){

  # generator loop for Q
  for(i in 1:80){
    Q[i] <- i*10
  }
  Q_col <- Q
  # create hQ/2D
  hQby2D_col <- (h/(2*D))*Q
  # create A/Q
  AbyQ_col <-  (A)/Q
  # replicate c
  c_col <- rep_len(c,length(Q))
  # Calculate Total
  total <-  hQby2D_col + AbyQ_col + c_col
  # create the output dataframe
  df <- data.frame(Order_Quantity = Q_col,  Unit_Holding_Cost = hQby2D_col, Unit_Setup_Cost = AbyQ_col
                   , Unit_Production_Cost =c_col, Total_Cost =total)
  return(df)
}
