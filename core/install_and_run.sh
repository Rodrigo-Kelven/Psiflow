#!/bin/bash

echo "Atualizando o sistema e instalando dependências..."
sudo apt update && sudo apt install -y python3 python3-pip curl

echo "Instalando dependências do projeto..."
pip install fastapi uvicorn ollama
pip install "fastapi[standard]"

echo "Instalando o Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

echo "Baixando o modelo Mistral..."
ollama pull mistral

echo "Baixando torch"
pip install torch
