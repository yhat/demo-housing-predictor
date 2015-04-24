library(yhatr)
library(jsonlite)

df <- read.delim('../model/manhattan_house.txt', skip=1)
df$ZIP <- as.factor(df$ZIP)

summary(df)
df <- df[df$Price<11000,]
df <- df[df$Total.Rooms<100,]

summary(df)
features <- c('Price','Bedrooms','Baths','Sqft','Neighborhood')
df2 <-df[features]
fit <- lm(Price ~ .,data=df2)
summary(fit)

break1 <- c(0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000)
hist(df2$Price,freq=FALSE,breaks=break1)

model.require <- function() {
}

model.transform <- function(df){
  df
}

model.predict <- function(df) {
  predicted_price <- predict(fit, newdata=data.frame(df))
  result = data.frame(predicted_price)
  #hist
  sub_bd <- df2[df2$Bedrooms==df$Bedrooms,]
  break1 <- c(0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000)
  x2 <-hist(sub_bd$Price,breaks=break1)
  x <- x2$mids
  y <- x2$density
  result2 <- data.frame(list("x"=x,"y"=y))
  results <- list(result,result2)
  print(results)
}

out <- model.predict(data)
out

yhat.config  <- c(
  username="YHAT_USERNAME",
  apikey="YHAT_APIKEY",
  env="http://sandbox.yhathq.com/"
)

yhat.deploy("NycRentViz01")

print(toJSON(df2[1,]))

data <- fromJSON('{"Price":4000,"Bedrooms":2,"Baths":1,"Sqft":990,"Neighborhood":"Sutton Place"}')
yhat.predict("NycRentViz", data, raw_input=TRUE)
