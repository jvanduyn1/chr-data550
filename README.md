# DATA550 Final Project: County Health Rankings & Roadmaps Dataset

# Summary

The report generated provides an analysis of rural vs. urban US counties from 2016-2025 using the County Health Rankings & Roadmaps data. We look at how infant mortality, child poverty, years of potential life lost, and primary care physicians over time vary between the urban and rural county categories. The report includes a descriptive table and a plot showing how the number of primary care physicians changed over time.

# Report

The following packages are required:

- dplyr

- janitor

- ggplot2

- knitr

- labelled

- gtsummary

- rmarkdown

Run $\texttt{make}$ in the terminal from the repository root. This produces $\texttt{report.html}$.

# Repo Contents

- $\texttt{report.Rmd}$: report, including an intro, the relevant research question, data cleaning summary, table, figure, interpretation)
- $\texttt{Makefile}$: rules for building the report
- $\texttt{code/01\_clean\_data.R}$: reads/merges raw data and cleans data, adds urban/rural indicator
- $\texttt{code/02\_create\_table.R}$: creates the table ($\texttt{output/table.rds}$)
-  $\texttt{code/03\_create\_figure.R}$ creates the figure ($\texttt{output/figure.png}$)
- $\texttt{code/04\_render\_report.R}$ renders the report ($\texttt{report.html}$)
- $\texttt{data/raw/}$ original County Health Rankings data (ranked and additional, by year)
  - Data is separated into ranked and additional categories on the website, and I decided to merge these for each year.
- $\texttt{data/derived/}$: cleaned dataset
- $\texttt{output/}$: generated table and figure

# Source

County Health Rankings & Roadmaps, <https://www.countyhealthrankings.org/>
