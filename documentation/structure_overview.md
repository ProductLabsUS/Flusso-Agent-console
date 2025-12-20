
# Project Structure Overview (Beginner Friendly)

This document explains the folder and file structure of the Agent Assistance Bot project. Each part is described in simple terms so you can understand what it does.

## Directory Tree

```
Agent-Assistance-Bot/
│
├── ARCHITECTURE.md         # Project architecture and design notes
├── build.sh                # Script to build the project (optional)
├── cloudbuild.yaml         # Google Cloud Build configuration
├── Dockerfile              # Instructions to build a Docker image
├── nginx.conf              # NGINX web server configuration (optional)
├── README.md               # Main project documentation
├── render.yaml             # Render.com deployment configuration
├── requirements.txt        # List of Python packages needed for backend
├── start.sh                # Script to start the app (optional)
│
├── client/                 # Frontend (what you see in your browser)
│   ├── app.js              # Main JavaScript code for the website
│   ├── config.js           # Settings for the frontend
│   ├── index.html          # The main web page
│   ├── styles.css          # Styles for the web page
│   └── icons/              # Images and icons (like the logo and favicon)
│       ├── favicon.ico     # Website icon shown in browser tab
│       └── logo.png        # Project logo
│
├── server/                 # Backend (the Python server)
│   ├── __init__.py         # Marks this folder as a Python package
│   ├── test_data_loader.py # Script to test loading data
│   ├── data/               # Data files used by the backend
│   │   ├── metadata_manifest.json  # Example data file
│   │   └── Product-2025-11-12.xlsx # Example Excel data file
│   └── app/                # Main backend application code
│       ├── __init__.py     # Marks this folder as a Python package
│       ├── main.py         # Entry point for the FastAPI backend
│       ├── core/           # Core logic
│       │   ├── __init__.py
│       │   ├── orchestrator.py    # Orchestrates main logic
│       │   └── prompts.py         # Manages prompts for the AI
│       ├── routers/        # API endpoints (URLs)
│       │   ├── __init__.py
│       │   ├── api.py      # Main API routes
│       │   └── health.py   # Health check route
│       └── services/       # Helper services
│           ├── __init__.py
│           ├── data_loader.py     # Loads product data
│           ├── freshdesk.py       # Integrates with Freshdesk
│           └── gemini_service.py  # Integrates with Gemini AI
│
└── documentation/          # Project documentation (this folder)
        ├── structure_overview.md      # This file
        └── installation_manual.md     # Step-by-step installation guide
```

## What Each Part Does

- **client/**: Everything for the website you see and use.
    - `index.html`: The main web page.
    - `app.js`: The main logic for the website.
    - `styles.css`: How the website looks (colors, layout, etc).
    - `icons/`: Images and icons for the website.

- **server/**: The backend server that does the heavy lifting.
    - `app/`: The main backend code, organized into:
        - `main.py`: Starts the backend server (FastAPI).
        - `core/`: Main logic and AI prompt management.
        - `routers/`: Defines the URLs (API endpoints) the frontend can call.
        - `services/`: Loads data and connects to outside services (like Freshdesk, Gemini AI).
    - `data/`: Data files used by the backend (like product lists).

- **requirements.txt**: List of Python packages you need to install for the backend.
- **README.md**: Main instructions and information about the project.
- **Dockerfile**: Lets you build and run the project in a Docker container (optional for beginners).
- **documentation/**: Extra guides and help for using and understanding the project.

---
This structure keeps the frontend, backend, data, and documentation organized and easy to find for new users.
