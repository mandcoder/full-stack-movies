import pandas as pd
import ast

from backend.constants import CLEAN_DATA_PATH

movies_df = pd.read_csv(CLEAN_DATA_PATH / "imdb_movies.csv")
movies_df["genres"] = movies_df["genres"].apply(
    ast.literal_eval
)  # denn behövs för det skall visa taggar i genres kolumnen i appen.
