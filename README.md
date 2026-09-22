# Full-Stack Movies

A full-stack data application for exploring and analyzing movie data.

The project combines data preparation, exploratory data analysis, a Python backend API, an interactive frontend dashboard, containerization with Docker, and infrastructure as code with Terraform.

The goal of the project is to demonstrate how raw movie data can move through processing and API exposure to an interactive application, while also incorporating deployment-oriented technologies and cloud infrastructure.

## Project Overview

The application is structured into separate backend, frontend, data, container, and infrastructure components.

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

The application follows a modular full-stack architecture:

```text
Raw movie data
      │
      ▼
Data preparation
      │
      ▼
Data processing
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
│   │   └── raw
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

> **Note:** Raw and processed datasets are stored locally under `backend/data/` and are excluded from version control. Terraform state files, virtual environments, generated Python cache files, and other local artifacts are also excluded through `.gitignore`.

## Backend

The backend is responsible for preparing, processing, and exposing the movie data.

The backend source code is organized into several modules:

- `api.py` – defines the backend API
- `data_prep.py` – handles data preparation
- `data_processing.py` – handles movie data processing
- `constants.py` – contains shared backend constants

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

The project separates raw source data from processed application-ready data.

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

This structure creates a clear separation between the original dataset and the transformed data consumed by the application.

The dataset itself is kept outside version control, while the code responsible for processing it remains part of the repository.

## Exploratory Data Analysis

Exploratory analysis is performed in:

```text
eda_imdb.ipynb
```

The notebook is used to explore and understand the movie dataset before it is prepared and processed for use by the application.

Keeping exploratory analysis separate from production application code helps maintain a clear distinction between data investigation and application logic.

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

Terraform is used to define the Azure infrastructure associated with the project.

The infrastructure is separated into application and container registry configurations.

### Registry Infrastructure

The `registry` directory contains Terraform configuration related to the Azure Container Registry and supporting Azure resources.

### Application Infrastructure

The `apps` directory contains the Terraform configuration for the application infrastructure.

Separating infrastructure from application code keeps the cloud architecture explicit, reproducible, and version controlled.

Terraform state files are intentionally excluded from the repository because they represent environment-specific infrastructure state rather than source code.

## Python Workspace

The repository is organized as a small monorepo.

The root `pyproject.toml` defines a `uv` workspace containing:

```text
backend
frontend
```

Each component also has its own `pyproject.toml`.

This allows the backend and frontend to maintain their own package configuration while still being managed as part of the same project.

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

The repository separates the main responsibilities of the application:

```text
Data           → raw and processed movie data
Backend        → processing and API layer
Frontend       → interactive dashboard
Docker         → application containerization
Infrastructure → Azure resources defined with Terraform
```

This structure keeps clear boundaries between:

- Data preparation and processing
- Backend services
- Frontend presentation
- Container configuration
- Cloud infrastructure

## What This Project Demonstrates

This project demonstrates several areas involved in building a data-driven full-stack application:

- Structuring a Python project into independent application components
- Separating raw and processed data
- Preparing movie data for application use
- Performing exploratory data analysis
- Building an API layer around processed data
- Creating an interactive data dashboard
- Containerizing backend and frontend services
- Managing multiple services with Docker Compose
- Defining cloud infrastructure with Terraform
- Working with Azure Container Registry
- Separating infrastructure from application code
- Managing a multi-package Python repository with `uv`
- Using Git and GitHub for version control
