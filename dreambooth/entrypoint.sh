#!/bin/bash

# Save stable diffusion model
#curl -C - -Lo ./models/v1-5-pruned-emaonly.safetensors https://huggingface.co/stable-diffusion-v1-5/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors

# Train stable diffusion model on fine-tuning images
accelerate launch /app/examples/dreambooth/train_dreambooth.py \
  --instance_data_dir="./training_input" \
  --instance_prompt="$SAMPLE_PROMPT" \
  --pretrained_model_name_or_path="stable-diffusion-v1-5/stable-diffusion-v1-5" \
  --max_train_steps=1000 \
  --output_dir="./training_output" \
  --revision="main" \
  --seed=1337 \
  --resolution=512 \
  --train_batch_size=1 \
  --train_text_encoder \
  --mixed_precision="fp16" \
  --use_8bit_adam \
  --gradient_accumulation_steps=1 \
  --learning_rate=1e-6 \
  --lr_scheduler="constant" \
  --lr_warmup_steps=0 \
  --num_class_images=1 \
  --sample_batch_size=1
