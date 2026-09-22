from fastapi import FastAPI
from backend.data_processing import movies_df
from typing import Optional

app = FastAPI()


@app.get("/imdb_action_movies")
async def show_data(
    limit: Optional[int] = 30,
):  # Jag sätter denna till None innan produktion
    if limit is None or limit <= 0:
        return movies_df.to_dict(orient="records")

    return movies_df.head(limit).to_dict(orient="records")
