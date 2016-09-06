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

[Correlation](https://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient#Testing_using_Student.27s_t-distribution)
