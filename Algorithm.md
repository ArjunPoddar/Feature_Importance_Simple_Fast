In predictive modeling (regression or classification) the goal is to
find the effect that any feature has on the response variable. This
effect is known as the **feature importance**.

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
