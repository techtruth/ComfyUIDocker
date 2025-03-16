FROM ubuntu AS base

# Update system and install required packages
RUN apt-get -q update; apt-get -q upgrade; \
    apt-get install -y \
    git \
    curl \
    gcc \
    software-properties-common \
    libgl1 \
    libglib2.0-0 \
    nvidia-cuda-toolkit; # \
    #python3 python-is-python3 python3-venv python3-dev; \
    apt-get clean

RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get -q update; apt-get install python3.10 python3.10-venv python3.10-dev -y

# Make application folder and set user
RUN mkdir /app; chown ubuntu:ubuntu /app
USER ubuntu

# Clone source code repository
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui /app
RUN ls -a /app
WORKDIR /app

# Setup python environment
ENV PATH="/app/bin:${PATH}"
RUN python3.10 -m venv venv

EXPOSE 7860/tcp

ENTRYPOINT ["/bin/bash", "webui.sh", "--listen", "--no-half", "--enable-insecure-extension-access"]
