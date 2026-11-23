report.html: report.Rmd output/table.rds output/figure.png
	Rscript code/04_render_report.R

data/derived/project_data.csv: code/01_clean_data.R
	Rscript code/01_clean_data.R

output/table.rds: code/02_create_table.R data/derived/project_data.csv
	Rscript code/02_create_table.R

output/figure.png: code/03_create_figure.R data/derived/project_data.csv
	Rscript code/03_create_figure.R
	
.PHONY: install
install: 
	Rscript -e "renv::restore(prompt = FALSE)"