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
	
# Docker associated rule 

PROJECTFILES = code/Project_R_Markdown.Rmd code/render_report.R code/make_figure.R code/make_table.R Makefile
RENVEFILES = renv.lock renv/activate.R renv/settings.dcf

# Rule to build an image
project_image: Dockerfile $(PROJECTFILES) $(RENVEFILES)
	docker build -t cliff98/final_project .
	touch $@

# Rule to run container 
report/report.html: 
	docker run -v "/$$(pwd)/report":/project/report cliff98/final_project
	