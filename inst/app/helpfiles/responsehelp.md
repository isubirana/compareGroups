**Select which variable indicates the group.**

Three choices are possible:

- **None:** Descriptives are performed for the entire data set with no groups.

- **Group:** A variable must be selected. By default, only factors variables with five or less categories can be selected. The descriptives will be performed by the groups defined by this variable. If a binary variable is selected you can compute the Odds Ratio or the Risk Ratio. Different options are available to estimate them (see `risk.ratio` or `odds.ratio` from <a href="https://cran.r-project.org/web/packages/epitools/epitools.pdf" target="_blank">epitools package</a> for more information).

- **Survival:** Use this options to perform survival analysis where the response is a right censored variable, i.e., with time variable and a variable indicating the censoring status (i.e., whether or not the individual suffered the disease). Also, the disease or case status (category) must be indicated.
