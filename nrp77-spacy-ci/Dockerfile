FROM continuumio/miniconda3:latest

RUN wget --header "PRIVATE-TOKEN: ${NRP77_NLP_ANALYSIS_REPO_TOKEN}" https://gitlab.dev.si.usi.ch/api/v4/projects/297/repository/files/environment.yml/raw --output-document=environment.yml

RUN conda env create -f environment.yml
RUN source activate nlp
RUN python -m spacy download en_core_web_trf
RUN python -m spacy download fr_dep_news_trf
RUN python -m spacy download fr_core_news_lg
RUN python -m spacy download de_dep_news_trf
RUN python -m spacy download de_core_news_lg