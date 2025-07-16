FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

RUN apt-get update && apt-get install -y \
    python3.8 python3-pip git wget && \
    ln -sf /usr/bin/python3.8 /usr/bin/python3

WORKDIR /app
COPY . /app

# Install base pip tools (downgraded pip + patched wheel)
RUN pip3 install --upgrade pip==20.2.4 && \
    pip3 install setuptools==57.5.0 wheel==0.32.3

# Install requirements
RUN pip3 install -r requirements.txt

# Download spaCy model using CLI (not from tar.gz)
RUN python3 -m spacy download en_core_web_lg

CMD ["python3", "run.py", "--RUN=train", "--MODEL=mcan_small", "--VIS_FEAT=CenterPoint", "--GPU=0"]
