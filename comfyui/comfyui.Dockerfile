FROM ubuntu AS base

# Update system and install required packages
RUN apt-get -q update; \
    apt-get -q upgrade; \
    apt-get install -y \
      git \
      curl \
      python3 python-is-python3 python3-venv \
      libgl1 \
      libglib2.0-0; \
    apt-get clean

# Make application folder and set user
RUN mkdir /app; chown ubuntu:ubuntu /app
USER ubuntu

# Clone source code repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /app
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager /app/custom_nodes/Comfyui-Manager
RUN git clone https://github.com/techtruth/ComfyUI-Dreambooth.git /app/custom_nodes/Dreambooth
WORKDIR /app

# Setup python environment
ENV PATH="/app/bin:${PATH}"
RUN env
RUN python -m venv .

# Install dependencies
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu126
RUN pip install -r requirements.txt


EXPOSE 8188/tcp
COPY --chown=ubuntu:ubuntu entrypoint.sh entrypoint.sh
RUN chmod 700 entrypoint.sh

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
