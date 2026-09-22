# 1. Starta från en slimmad Python 3.13-avbild
FROM python:3.13-slim

# 2. Kopiera hela backend-mappen (inklusive data, pyproject och src)
COPY backend/ /app

# 2. Installera uv i imagen
RUN pip install uv --no-cache-dir

# 3. Sätt arbetskatalogen i containern till /app
WORKDIR /app

# 4. Kopiera projektets centrala paketfiler (från roten på din dator)
#COPY pyproject.toml uv.lock ./

# 6. Installera alla dependencies via uv (utan utvecklingsverktyg)
RUN uv sync --no-dev

# 7. Sätt arbetskatalogen till där din api.py faktiskt bor i containern
WORKDIR /app/src/backend

# 8. Berätta att containern lyssnar på port 8000
EXPOSE 8000

# detta startar när appen körs
# 9. Starta appen (vi kör 'uv run uvicorn' i den katalog där api.py ligger)
CMD ["uv", "run","--no-sync","uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8000"]
