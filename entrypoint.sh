#!/bin/bash

## Download models
curl \
  -C \
  -L \
  -o /app/models/checkpoints/v1-5-pruned-emaonly-fp16.default.safetensors \
  https://huggingface.co/Comfy-Org/stable-diffusion-v1-5-archive/resolve/main/v1-5-pruned-emaonly-fp16.safetensors

## Run ComfyUI
python main.py --listen 0.0.0.0 $@
