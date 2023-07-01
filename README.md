# Forecast-the-turnover-of-household-goods-retailing


This project is about forecast the turnover of household goods retailing. The data series is included in the Retail Trade, Australia (code: 8501.0) with a Series ID A3348600A.

The project is mainly done by using MATLAB. Input data for models are CSV files downloaded from Australian Bureau of Statistics but currently not able to be uploaded yet on this repository, you can still find them on the official website of abs. All codes are provided in the end of the wold document.  


---------------

Discriptions:

For this project, I plan to forecast the turnover of household goods retailing. The data series is included in the Retail Trade, Australia (code: 8501.0) with a Series ID A3348600A.
Household goods retailing is a significant component of Australian Retail Trade. The change of its turnover can intuitively reflect the demand in the household retailing market, outlook of Australian Retail Trade, and consumption level. In addition, Retail Trade has been a significant part for contributing Australia’s economy for a long period. Observing the household retailing past turnover will not only helps us make valuable forecast but also gives us hints about economy’s trends and cycles. This data series is published by Australian Bureau of Statistics (ABS) monthly since 1982, it can be obtained from the data downloads table 1 on the ABS website:
https://www.abs.gov.au/statistics/industry/retail-and-wholesale-trade/retail-trade-australia/latest-release#data-download 
The upcoming release for Retail Trade, Australia is 4th November 2020.  

-------------------

Evaluation methods:
- MSFE one and three steps ahead forecast

Benchmark:
- random walk
 
Models:
- AR 
- IAR
- ARMA
- OLS with seasonal dummies
- Holt-Winter model

---------

Conclusion
1. The data series have a relatively clear trend and seasonality, which reflects into the MSFE from models.
  
2. The explanatory variables of employment improve the forecast a lot, which gives the intuition about adding more potential variables could make more accurate forecast.
  
3. The data series looks like auto-regressive and these AR and IAR models truly give us the better MSFE compared to random walk.   
  
4. Moving average assumption is terrible, it destroys models and makes very large MSFEs, which obviously should not be considered into any model for original data.
  
5. Using first difference ∆y helps us to get better MSFEs for AR but those are still larger than previous model forecasts. However, it is much worse when using the ARMA models, which gives me the most reason for stopping using MA in the forecast.
  
6. Trend cycle model is not a very bad model for forecasting, which even performs better than AR(p); but the unobserved component model does not perform well. 

7. Overall, the Holt-winter, S4 and S’4 are best forecast specifications.

8. Although Holt-Winter gives the smallest MSFE, this model has hysteresis, which may result in not very precise forecast when seasonality starts to influence the data series. Considering those two models together may give a much accurate forecast.   
