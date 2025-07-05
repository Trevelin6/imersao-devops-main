# 1. Imagem Base
# Usando uma imagem "slim" que é um bom compromisso entre tamanho e funcionalidades.
# O readme menciona Python 3.10+, então 3.11 é uma escolha segura e estável.
FROM python:3.11-slim-bullseye

# 2. Define o diretório de trabalho dentro do container
WORKDIR /app

# 3. Copia o arquivo de dependências e as instala
# Isso aproveita o cache de camadas do Docker. As dependências só serão reinstaladas
# se o arquivo requirements.txt for alterado.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copia o restante do código da aplicação
COPY . .

# 5. Expõe a porta em que a aplicação irá rodar
EXPOSE 8000

# 6. Comando para iniciar a aplicação
# Usamos 0.0.0.0 para que o servidor seja acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]