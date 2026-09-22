# välj image
FROM python:3.13-slim

# kopierar koden till min image
COPY frontend/ /app/

# installerar uv i imagen, --no-cache-dir gör att pip inte behåller sin nedladningscache, vilket göra att docker imagen blir mindre.

RUN pip install uv --no-cache-dir


# talar om för docker vilken katalog i imagen som skall vara arbetskatalog
# detta är samma som att skriva cd app i terminalen
WORKDIR /app

#installerar dependencies som projektet behöver, i min pyproject.toml finns ["uvicoren", "fastapi","pandas"]
# detta skapar/synkar miljön inne i docker-filen
RUN uv sync --no-dev --no-cache


WORKDIR /app/src/frontend

# containern använder streamlits standardport 8501
EXPOSE 8501

# detta skall köras när containern startas. --host 0.0.0.0 --> uvicorn behöver lyssna på alla interface
CMD [ "uv", "run", "--no-sync", "streamlit","run","dashboard.py","--server.address=0.0.0.0", "--server.port=8501" ]