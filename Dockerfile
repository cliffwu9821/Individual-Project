From rocker/r-ubuntu

RUN apt-get update && apt-get install -y pandoc libcurl4-openssl-dev libssl-dev libxml2-dev libfontconfig1-dev

RUN mkdir /project
WORKDIR /project

RUN mkdir code
RUN mkdir output
RUN mkdir data


COPY code code
COPY output output
COPY data data
COPY Makefile .
COPY README.md .
COPY .gitignore .

COPY .Rprofile .
COPY renv.lock . 

RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.dcf renv


RUN Rscript -e "renv::restore(prompt=FALSE)"

RUN mkdir report
CMD make && mv code/Project_R_Markdown.html report