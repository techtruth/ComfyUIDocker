FROM ubuntu AS base

# Update system and install required packages
RUN apt-get -q update; \
    apt-get -q upgrade; \
    apt-get install -y \
      git \
      curl \
      gcc \
      software-properties-common \
      libgl1 \
      libglib2.0-0 \
      nvidia-cuda-toolkit \
      python3 python-is-python3 python3-venv python3-dev; \
    apt-get clean

# Make application folder and set user
RUN mkdir /app; chown ubuntu:ubuntu /app
USER ubuntu

# Clone source code repository
RUN git clone https://github.com/huggingface/diffusers.git /app
WORKDIR /app

# Setup python environment
RUN python -m venv venv
ENV PATH="/app/venv/bin:${PATH}"

# Install dependencies in python
RUN pip install -r ./examples/dreambooth/requirements.txt
RUN pip install git+https://github.com/huggingface/diffusers
RUN pip install bitsandbytes deepspeed

COPY --chown=ubuntu:ubuntu --chmod=700 entrypoint.sh entrypoint.sh

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
