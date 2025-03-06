#!/bin/bash

echo "Atualizando o sistema e instalando dependências..."
sudo apt update && sudo apt install -y python3 python3-pip curl

echo "Instalando dependências do projeto..."
pip install fastapi uvicorn ollama

echo "Instalando o Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

echo "Baixando o modelo Mistral..."
ollama pull mistral

echo "Criando o arquivo main.py..."
cat <<EOF > main.py
from fastapi import FastAPI
from pydantic import BaseModel
import ollama

app = FastAPI()

class ChatRequest(BaseModel):
    message: str

@app.post("/chat")
def chat(request: ChatRequest):
    response = ollama.chat(model="mistral", messages=[{"role": "user", "content": request.message}])
    return {"response": response["message"]["content"]}
EOF

echo "Iniciando a API FastAPI..."
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
