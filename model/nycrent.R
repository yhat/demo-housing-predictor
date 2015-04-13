library(yhatr)
library(jsonlite)

df <- read.delim('./manhattan_house.txt', skip=1)
df$ZIP <- as.factor(df$ZIP)

summary(df)
df <- df[df$Price<11000,]
df <- df[df$Total.Rooms<100,]

summary(df)
features <- c('Price','Bedrooms','Baths','Sqft','Neighborhood')
df2 <-df[features]
fit <- lm(Price ~ .,data=df2)
summary(fit)

model.require <- function() {
}

model.transform <- function(df){
  df
}

model.predict <- function(df) {
  predicted_price <- predict(fit, newdata=data.frame(df))
  result = data.frame(predicted_price)
  print(result)
}

yhat.config  <- c(
  username="YHAT_USERNAME",
  apikey="YHAT_APIKEY",
  env="http://cloud.yhathq.com/"
)

yhat.deploy("NycRent")

print(toJSON(df2[1,]))
