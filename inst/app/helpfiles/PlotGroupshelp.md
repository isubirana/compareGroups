Three choices are possible:

- **None:** Plot is performed for the entire data set with no groups.

- **Group:** A variable must be selected. By default, only factors variables with five or less categories can be selected.
  - If the plotted variable is numeric, boxplots by groups are displayed.
  - If the plotted variable is categorical (factor), side barplots are displayed.
  - If the plotted variable is of survival class Kaplan-Meier curves are displayed.
  
- **Survival:** Select time to event variable, censoring variable and event categories. 
  - If the plotted variable is numeric, scatter plot is displayed with non-censored events coloured in red.
  - If the plotted variable is categorical (factor), Kaplan-Meier curves are displayed.

_Note: the "survival" button option is only possible if the plotted variable is not of class survival._
  

