# Full-Stack Movies

A full-stack data application for exploring and analyzing movie data.

The project combines data preparation, exploratory data analysis, a Python backend API, an interactive frontend dashboard, containerization with Docker, and infrastructure as code with Terraform.

The goal of the project is to demonstrate how a dataset can move from raw source data through processing and API exposure to an interactive application, while also incorporating deployment-oriented technologies.

## Project Overview

The application is structured into separate backend, frontend, data, and infrastructure components.

The project includes:

- Data preparation and transformation with Python and Pandas
- Exploratory data analysis using Jupyter
- Backend API built with FastAPI
- Interactive dashboard built with Streamlit
- Separate backend and frontend Python packages
- Dockerized backend and frontend services
- Docker Compose for service orchestration
- Terraform infrastructure for Azure resources
- Azure Container Registry configuration
- Dependency and workspace management with `uv`

## Architecture

The project follows a modular full-stack architecture:

```text
Raw movie data
      │
      ▼
Data preparation / processing
      │
      ▼
Processed movie data
      │
      ▼
FastAPI backend
      │
      ▼
Streamlit frontend
      │
      ▼
Interactive movie dashboard
```

Containerization and infrastructure are handled separately:

```text
Application
    │
    ├── Backend container
    │
    └── Frontend container
            │
            ▼
       Docker Compose

Infrastructure
    │
    ▼
 Terraform
    │
    ▼
Azure resources
```

## Project Structure

```text
.
├── README.md
├── backend
│   ├── README.md
│   ├── data
│   │   ├── processed
│   │   │   └── imdb_movies.csv
│   │   └── raw
│   │       └── imdb_movies.json
│   ├── pyproject.toml
│   └── src
│       └── backend
│           ├── __init__.py
│           ├── api.py
│           ├── constants.py
│           ├── data_prep.py
│           └── data_processing.py
│
├── docker-compose.yaml
│
├── dockerfiles
│   ├── backend.dockerfile
│   └── frontend.dockerfile
│
├── eda_imdb.ipynb
│
├── frontend
│   ├── README.md
│   ├── assets
│   │   └── action_movies.png
│   ├── pyproject.toml
│   └── src
│       └── frontend
│           ├── __init__.py
│           ├── dashboard.py
│           └── image_path_helper.py
│
├── infra
│   ├── apps
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   └── variables.tf
│   │
│   └── registry
│       ├── acr.tf
│       ├── providers.tf
│       ├── resources-group.tf
│       └── variables.tf
│
├── pyproject.toml
└── uv.lock
```

> Local datasets, Terraform state files, virtual environments, Python cache files, and other generated files are excluded from version control through `.gitignore`.

## Backend

The backend is responsible for preparing, processing, and exposing the movie data.

The backend source code is organized into several modules:

- `api.py` – backend API
- `data_prep.py` – data preparation
- `data_processing.py` – movie data processing
- `constants.py` – shared backend constants

The backend is maintained as its own Python package with a dedicated `pyproject.toml`.

## Frontend

The frontend provides the interactive user interface for exploring the movie data.

The main dashboard is implemented in:

```text
frontend/src/frontend/dashboard.py
```

Supporting frontend functionality is separated into helper modules and assets.

The frontend is maintained as a separate Python package with its own `pyproject.toml`.

## Data Pipeline

The project separates raw and processed data:

```text
backend/data/raw/
        │
        ▼
Data preparation
        │
        ▼
Data processing
        │
        ▼
backend/data/processed/
```

This separation keeps source data independent from application-ready datasets and makes the transformation flow easier to maintain and understand.

## Exploratory Data Analysis

Exploratory analysis is performed in:

```text
eda_imdb.ipynb
```

The notebook is used to inspect and understand the movie dataset before the data is prepared for use by the application.

## Docker

The backend and frontend are containerized independently:

```text
dockerfiles/
├── backend.dockerfile
└── frontend.dockerfile
```

`docker-compose.yaml` defines the application services and provides a common configuration for the containerized backend and frontend.

This separation allows the two application components to be built and managed independently.

## Infrastructure as Code

Infrastructure configuration is maintained under:

```text
infra/
├── apps/
└── registry/
```

Terraform is used to describe the Azure infrastructure required by the project.

The infrastructure is separated into application and container registry configurations.

### Registry Infrastructure

The `registry` configuration contains resources related to the Azure Container Registry and its supporting Azure resources.

### Application Infrastructure

The `apps` configuration contains the Terraform configuration for the application infrastructure.

Keeping infrastructure separate from application code makes the deployment architecture explicit and version controlled.

## Technology Stack

| Area | Technology |
|---|---|
| Language | Python |
| Data Processing | Pandas |
| Data Analysis | Jupyter |
| Backend | FastAPI |
| Frontend | Streamlit |
| Containers | Docker |
| Service Orchestration | Docker Compose |
| Infrastructure as Code | Terraform |
| Cloud | Microsoft Azure |
| Container Registry | Azure Container Registry |
| Dependency Management | uv |
| Version Control | Git / GitHub |

## Repository Design

The repository is organized as a small monorepo.

The root `pyproject.toml` defines a `uv` workspace containing:

```text
backend
frontend
```

Each application component also has its own `pyproject.toml`, allowing backend and frontend dependencies to remain separated while still being managed from the same repository.

This structure keeps clear boundaries between:

- data processing
- backend services
- frontend presentation
- container configuration
- cloud infrastructure

## What This Project Demonstrates

This project demonstrates several areas involved in building a data-driven application:

- Structuring a Python project into independent application components
- Preparing raw data for application use
- Performing exploratory data analysis
- Building an API layer around processed data
- Creating an interactive data dashboard
- Containerizing multiple application services
- Managing application services with Docker Compose
- Defining cloud infrastructure with Terraform
- Organizing Azure infrastructure separately from application code
- Managing a multi-package Python repository with `uv`
- Using Git and GitHub for version control
