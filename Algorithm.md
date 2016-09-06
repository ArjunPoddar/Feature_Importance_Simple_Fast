In predictive modeling (regression or classification) the goal is to
find the effect that any feature has on the response variable. This
effect is known as the **feature importance**.

We consider the cases when the response and the features are either
quantitative or qualitative. For the purpose of this project, to keep it
simple, we do not consider variables that are of other types- such as
datetime.

In general, when fitting a predictive model we get the feature
importances at the end of fitting the model. This can be very
time-consuming depending on the size of the data and the
repetition(bagging, boosting etc.) as the whole set of features are
generally used in the model. Here, we take a very simple one-by-one
feature approach. For each feature, we test its relation to the
response. The test is decided based on the type of the response and the
feature as shown in the table below.

<table>
<thead>
<tr class="header">
<th align="left">Response</th>
<th align="left">Feature</th>
<th align="left">Test</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Quantitative</td>
<td align="left">Quantitative</td>
<td align="left">Correlation</td>
</tr>
<tr class="even">
<td align="left">Quantitative</td>
<td align="left">Qualitative</td>
<td align="left">Kruskal-Wallis</td>
</tr>
<tr class="odd">
<td align="left">Qualitative</td>
<td align="left">Quantitative</td>
<td align="left">Kruskal-Wallis</td>
</tr>
<tr class="even">
<td align="left">Qualitative</td>
<td align="left">Quantitative</td>
<td align="left">Chi-squared or Fisher's exact</td>
</tr>
</tbody>
</table>

When the response is quantitative(numeric, continuous) a regression
model is appropriate. If the feature is also quantitative, a simple
linear regression is sufficient

    y <- runif(1000000, -4, 5)
    x <- rnorm(1000000, 65, 9)

    ptm <- proc.time()
    # summary(lm(Sepal.Length ~ Petal.Length, data = iris))
    summary(lm(y ~ x))

    ## 
    ## Call:
    ## lm(formula = y ~ x)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -4.5018 -2.2471 -0.0031  2.2508  4.5018 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.4931267  0.0189476  26.026   <2e-16 ***
    ## x           0.0001107  0.0002888   0.384    0.701    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 2.598 on 999998 degrees of freedom
    ## Multiple R-squared:  1.471e-07,  Adjusted R-squared:  -8.529e-07 
    ## F-statistic: 0.1471 on 1 and 999998 DF,  p-value: 0.7013

    proc.time() - ptm

    ##    user  system elapsed 
    ##   1.580   0.044   1.620

    ptm <- proc.time()
    # cor.test(iris$Sepal.Length, iris$Petal.Length)
    cor.test(y, x)

    ## 
    ##  Pearson's product-moment correlation
    ## 
    ## data:  y and x
    ## t = 0.3835, df = 1e+06, p-value = 0.7013
    ## alternative hypothesis: true correlation is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.001576465  0.002343463
    ## sample estimates:
    ##          cor 
    ## 0.0003835008

    proc.time() - ptm

    ##    user  system elapsed 
    ##   0.056   0.000   0.055

[Correlation](https://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient#Testing_using_Student.27s_t-distribution)
