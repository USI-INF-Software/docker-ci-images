FROM continuumio/miniconda3:latest

COPY environment.yml environment.yml

# setup environment
RUN conda env create -f environment.yml
RUN conda activate nlp

# download models
RUN python -m spacy download en_core_web_trf
RUN python -m spacy download fr_dep_news_trf
RUN python -m spacy download fr_core_news_lg
RUN python -m spacy download de_dep_news_trf
RUN python -m spacy download de_core_news_lg
