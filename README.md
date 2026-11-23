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

Run `make` in the terminal from the project root. This will produce `report.html`.

To synchronize the package repository, run `make install` in the terminal from the project root. This will restore each project package to the version specified in `renv.lock`.

# Repo Contents

- `report.Rmd`: final report, including an introduction, the research questions, a data cleaning summary, the table, the figure, and interpretation
- `Makefile`: rules for building the report
- `code/01_clean_data.R`: reads and merges the raw data, cleans it, and adds the urban/rural indicator
- `code/02_create_table.R`: creates the table (`output/table.rds`)
- `code/03_create_figure.R`: creates the figure (`output/figure.png`)
- `code/04_render_report.R`: renders the report (`report.html`)
- `data/raw/`: original County Health Rankings data (ranked and additional, by year)
  - The website splits the data into ranked and additional categories, so I merged these for each year.
- `data/derived/`: cleaned dataset
- `output/`: generated table and figure

# Source

County Health Rankings & Roadmaps, <https://www.countyhealthrankings.org/>
