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
linear regression is sufficient. But we will use a [correlation
test](https://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient#Testing_using_Student.27s_t-distribution)
instead. **Correlation test gives the same p-value as the linear
regression, on top of that it is faster**. Let us show this with an
example.

 

Let's generate two random variables:

    y <- runif(1000000, -4, 5)
    x <- rnorm(1000000, 65, 9)

 

Then run linear regression of y on x:

    ptm <- proc.time()
    # summary(lm(Sepal.Length ~ Petal.Length, data = iris))
    summary(lm(y ~ x))

    ## 
    ## Call:
    ## lm(formula = y ~ x)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -4.5119 -2.2489  0.0027  2.2476  4.5030 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.4847028  0.0189437  25.586   <2e-16 ***
    ## x           0.0003103  0.0002887   1.075    0.282    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 2.597 on 999998 degrees of freedom
    ## Multiple R-squared:  1.156e-06,  Adjusted R-squared:  1.556e-07 
    ## F-statistic: 1.156 on 1 and 999998 DF,  p-value: 0.2824

    proc.time() - ptm

    ##    user  system elapsed 
    ##   1.588   0.028   1.614

The p-value from the linear regression model is **0.06696** and the
elapsed time is **1.615 seconds**.

 

Now, to compare, we run a correlation test on y and x:

    ptm <- proc.time()
    # cor.test(iris$Sepal.Length, iris$Petal.Length)
    cor.test(y, x)

    ## 
    ##  Pearson's product-moment correlation
    ## 
    ## data:  y and x
    ## t = 1.075, df = 1e+06, p-value = 0.2824
    ## alternative hypothesis: true correlation is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.0008849837  0.0030349406
    ## sample estimates:
    ##         cor 
    ## 0.001074983

    proc.time() - ptm

    ##    user  system elapsed 
    ##   0.052   0.000   0.055

The p-value from the correlation test is \*\* \*\* and the elapsed time
is \*\* seconds\*\*.

We can see that though the p-values are same, the correlation test has a
much shorter execution time than the linear regression model (even for
just a million observations). When there are too many features and many
more observations, this difference can be really high. Thus using the
correlation test gives us the same inference in a much shorter execution
time.

\*Note: This illustration is based on randomly generated data. The
p-values and the execution times would be different each time we run
them- trust me, I almost forgot about it.
