from backend.constants import RAW_DATA_PATH, CLEAN_DATA_PATH

import pandas as pd
import ast

movies = []

# öppnar filen i readläge med UTF-8 encoding
with open(RAW_DATA_PATH / "imdb_movies.json", "r", encoding="UTF-8") as file:

    # läser filen rad för rad
    for line in file:
        movie = ast.literal_eval(
            line
        )  # konvterar varje rad från en sträng till python-dict

        movies.append(movie)


movies_df = pd.DataFrame(movies)

movies_df = movies_df[
    [
        "id",
        "primaryTitle",
        "releaseDate",
        "genres",
        "averageRating",
    ]
]

# ändrar namn på kolumnerna
movies_df = movies_df.rename(
    columns={
        "primaryTitle": "primary_title",
        "releaseDate": "release_date",
        "averageRating": "imdb_rating",
    }
)

movies_df = movies_df.rename(columns={"id": "imdb_id"})

movies_df = movies_df[
    [
        "imdb_id",
        "primary_title",
        "genres",
        "release_date",
        "imdb_rating",
    ]
]

movies_df = movies_df.dropna(subset=["imdb_rating", "release_date"])

movies_df.to_csv(CLEAN_DATA_PATH / "imdb_movies.csv", index=False)
