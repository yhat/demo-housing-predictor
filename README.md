# demo-rentpred

## NYC Rent Predictor

This demo takes a sample of NYC apartments and deploys a linear model to predict the price of apartments.

To deploy this model to ScienceOps, clone this repo (`git@github.com:yhat/demo-housing-predictor.git`).

Then run `rscript model/nycrent.R` to send the model to ScienceOps.

To run the application, run `node app.js`.

```
$ export YHAT_USERNAME="your username"
$ export YHAT_APIKEY="your apikey"
```
