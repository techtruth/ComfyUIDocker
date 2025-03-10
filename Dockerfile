FROM ubuntu AS base

# Update system and install required packages
RUN apt-get -q update; apt-get -q upgrade; \
    apt-get install -y \
    git \
    curl \
    python3 python-is-python3 python3-venv; \
    apt-get clean

# Make application folder and set user
RUN mkdir /app; chown nobody:nogroup /app
USER nobody

# Clone source code repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /app
RUN ls -a /app
WORKDIR /app

# Setup python environment
ENV PATH="/app/bin:${PATH}"
RUN env
RUN python -m venv .

# Install dependencies
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu126
RUN pip install -r requirements.txt

EXPOSE 8188/tcp
COPY --chown=nobody:nogroup --chmod=700 entrypoint.sh entrypoint.sh

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
