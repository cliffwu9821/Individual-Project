# Code Description 

`code/make_table.R`
- generates table for home advantage analysis
- saves the table as a `.rds` object in `output/` folder

`code/make_figure.R`
- generates figures for home advantage analysis, and France national team's game results.
- saves each the figures as a `.rds` object in `output/` folder

`code/02_render_report.R`
- renders `Project R Markdown.Rmd`

`Project R Markdown.Rmd`
- reads the table and figures generated by `code/make_table.R` and `code/make_figure.R`.
- makes the detailed report