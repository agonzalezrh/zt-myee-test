#!/bin/bash

echo "Setting up LiteLLM..." >> /root/setup-script.log

systemctl stop dnf-automatic-install.timer
systemctl disable dnf-automatic-install.timer
systemctl mask dnf-automatic-install.timer

echo "LITELLM_API_KEY: $LITELLM_API_KEY" >> /root/setup-script.log
echo $LITELLM_API_KEY >> /root/LITELLM_API_KEY
chmod 600 /root/LITELLM_API_KEY

cd /root
git clone https://github.com/block/goose.git
cd goose
echo "Building Goose..." >> /root/setup-script.log
go build -o goose cmd/goose/main.go
echo "Goose built successfully" >> /root/setup-script.log

./goose -api-key /root/LITELLM_API_KEY -model gpt-4o-mini -temperature 0.5 -max-tokens 1000 -messages "What is the weather in Tokyo?"

