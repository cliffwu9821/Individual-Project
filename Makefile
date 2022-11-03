report.html: code/make_table.R code/make_figure.R data/international_matches.csv table fig
	Rscript code/render_report.R

table: data/international_matches.csv 
	Rscript code/make_table.R

fig: data/international_matches.csv 
	Rscript code/make_figure.R
	
clean:
	rm -f output/*.rds && rm -f report.html
	
install:
	Rscript -e "renv::restore(prompt = FALSE)"