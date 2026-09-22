import streamlit as st
import httpx

from frontend.image_path_helper import PICT_PATH
import os

BASE_URL = os.getenv("BACKEND_URL", "http://127.0.0.1:8000")


def movie_page():

    st.markdown("# Action movies")

    st.image(PICT_PATH / "action_movies.png")

    movies = httpx.get(f"{BASE_URL}/imdb_action_movies", timeout=30).json()

    st.dataframe(movies)

    st.caption(
        """Movie data sourced from IMDb via RapidAPI.
               This is a personal learning project, not affiliated with or endorsed by IMDb."""
    )


if __name__ == "__main__":
    movie_page()
