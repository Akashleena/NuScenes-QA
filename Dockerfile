# Dockerfile
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

RUN apt-get update && apt-get install -y \
    python3.8 python3-pip git wget && \
    ln -s /usr/bin/python3.8 /usr/bin/python

WORKDIR /app
COPY . /app

RUN pip install --upgrade pip && \
    pip install setuptools==57.5.0 && \
    pip install -r requirements.txt

RUN wget https://github.com/explosion/spacy-models/releases/download/en_core_web_lg-2.1.0/en_core_web_lg-2.1.0.tar.gz && \
    pip install en_core_web_lg-2.1.0.tar.gz

CMD ["python3", "run.py", "--RUN=train", "--MODEL=mcan_small", "--VIS_FEAT=CenterPoint", "--GPU=0"]
