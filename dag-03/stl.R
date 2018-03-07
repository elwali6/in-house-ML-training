
# Parameters
start.ym <- c(2000, 1)
end.ym   <- c(2012,12)
n.years  <- 13

# Set the seed for the randomisation
set.seed(5)

# Create the 2nd derivative of the sales trend
ddtrend.sales <- qnorm(runif(12*n.years, 0.1, 0.90), mean=0, sd=0.4)

# Create the 1st derivative of the sales trend from the 2nd derivative
dtrend.sales    <- rep(NA, 12*n.years)
dtrend.sales[1] <- 0
for (i in 2:(12*n.years)) dtrend.sales[i] <- dtrend.sales[i-1] + ddtrend.sales[i]

# Create the sales trend from the 1st derivative
trend.sales    <- rep(NA, 12*n.years)
trend.sales[1] <- 30
for (i in 2:(12*n.years)){
  trend.sales[i] <- trend.sales[i-1] + dtrend.sales[i]
  if (trend.sales[i] < 0) trend.sales[i] = 0
}

# Create the seasonality
seasonality <- rep(c(10, 30, 22, 32, 26, 14, 2, -15, -14, -13, -16, -2), 13)

# Create the random noise, normally distributed
noise <- qnorm(runif(12*n.years, 0.01, 0.99), mean=0, sd=18)

# To make the noise heteroskedastic, uncomment the following line
# noise <- noise * seq(1, 10, (10-1)/(12*n.years-1))

# Create the sales
sales <- trend.sales + seasonality + noise

# Put everything into a data frame
df.sales <- data.frame(sales, trend.sales, dtrend.sales, ddtrend.sales, seasonality, noise)

# Set graphical parameters and the layout
par(mar = c(0, 4, 0, 2)) # bottom, left, top, right
layout(matrix(c(1,5,2,6,3,7,4,8), 4, 2, byrow = TRUE), widths=c(1,1,1,1,1,1,1,1), heights=c(1,1,1,1,1,1,1,1))

# Plot sales
tseries <- ts(data=df.sales$sales, frequency = 12, start=start.ym, end=end.ym)
plot(tseries, ylab="Sales (USD, 1000's)", main="", xaxt="n")

# Plot the trend
tseries <- ts(data=df.sales$trend.sales, frequency = 12, start=start.ym, end=end.ym)
plot(tseries, ylab="Actual Sales Trend (USD, 1000's)", main="", xaxt="n")

# Plot the seasonality
tseries <- ts(data=df.sales$seasonality, frequency = 12, start=start.ym, end=end.ym)
plot(tseries, ylab="Actual Sales Seasonality (USD, 1000's)", main="", xaxt="n")

# Plot the noise
tseries <- ts(data=df.sales$noise, frequency = 12, start=start.ym, end=end.ym)
plot(tseries, ylab="Actual Sales Noise (USD, 1000's)", main="", xaxt="n")

# Decompose the sales time series
undecomposed   <- ts(data=df.sales$sales, frequency = 12, start=start.ym, end=end.ym)
decomposed     <- stl(undecomposed, s.window="periodic")
seasonal 	   <- decomposed$time.series[,1]
trend	       <- decomposed$time.series[,2]
remainder	   <- decomposed$time.series[,3]

# Plot sales
tseries <- ts(data=df.sales$sales, frequency = 12, start=start.ym, end=end.ym)
plot(tseries, ylab="Sales (USD, 1000's)", main="", xaxt="n")

# Plot the decomposed trend
tseries <- ts(data=trend, frequency = 12, start=start.ym, end=end.ym)
plot(tseries, ylab="Est. Sales Trend (USD, 1000's)", main="", xaxt="n")

# Plot the decomposed seasonality
tseries <- ts(data=seasonal, frequency = 12, start=start.ym, end=end.ym)
plot(tseries, ylab="Est. Sales Seasonality (USD, 1000's)", main="", xaxt="n")

# Plot the decomposed noise
tseries <- ts(data=remainder, frequency = 12, start=start.ym, end=end.ym)
plot(tseries, ylab="Est. Sales Noise (USD, 1000's)", main="", xaxt="n")