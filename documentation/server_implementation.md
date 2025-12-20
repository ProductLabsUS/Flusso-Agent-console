# Server Implementation & Workflow (Agent Assist Console)

This document explains how the backend (server) of the Agent Assist Console works, what each file does, and how all the pieces fit together.

---

## 1. Overview: How the Server Works

- The backend is built with **FastAPI** (Python) and serves as the brain of the Agent Assist Console.
- It loads product data and media into memory at startup for fast access.
- It exposes API endpoints for the frontend to ask questions, get product info, and export notes to Freshdesk.
- It integrates with Google Gemini (GenAI) for LLM-powered answers and with Freshdesk for ticketing.
- The main workflow is a linear pipeline: **Extract → Retrieve → Synthesize → Format**.

---

## 2. Main Workflow (Request to Response)

1. **Frontend sends a query** (e.g., "How do I install the GC-303-T clamp?") to `/api/chat`.
2. **Orchestrator pipeline** runs:
   - **Extraction:** Finds product model number in the query (using regex/fuzzy matching).
   - **Retrieval:** Gathers product specs/media from in-memory data, and runs a file search (if needed) using Gemini.
   - **Synthesis:** Sends all context to Gemini LLM to generate a comprehensive answer.
   - **Formatting:** Packages the answer, media, and sources for the frontend.
3. **Response is returned** to the frontend, including:
   - Markdown answer
   - Media assets (videos, images, documents)
   - Sources and model info

---

## 3. File-by-File Breakdown

### server/app/main.py
- **Entry point for the backend.**
- Loads environment variables, initializes all services (data, Gemini, Freshdesk), and sets up the FastAPI app.
- Mounts the `client/` folder as static files (serves the frontend).
- Adds CORS middleware for cross-origin requests.
- Serves `/favicon.ico` from the correct location.
- Includes routers for API and health endpoints.

### server/app/core/orchestrator.py
- **The brain of the pipeline.**
- Coordinates the 4-stage process: Extraction, Retrieval, Synthesis, Formatting.
- Uses the product database, Gemini service, and prompts manager.
- Handles all logic for processing a user query and returning a structured response.

### server/app/core/prompts.py
- **Central place for all LLM system prompts.**
- Provides templates for synthesis, extraction, troubleshooting, and comparison queries.
- Ensures consistent, high-quality responses from the LLM.

### server/app/services/data_loader.py
- **Loads and manages all product data.**
- Loads product specs from Excel and media from JSON at startup.
- Provides fast lookup and fuzzy matching for model numbers.
- Returns structured product context (specs, media, documents, confidence).

### server/app/services/gemini_service.py
- **Handles all communication with Google Gemini (GenAI).**
- Supports both "flash" (fast) and "reasoning" (deep) LLM modes.
- Runs file search queries for documentation/manuals.
- Builds prompts and extracts sources for answers.

### server/app/services/freshdesk.py
- **Integrates with Freshdesk API.**
- Posts private notes to tickets with research results.
- Handles authentication and error handling.

### server/app/routers/api.py
- **Defines main API endpoints:**
  - `/api/chat`: Main endpoint for processing queries through the orchestrator.
  - `/api/freshdesk`: Exports notes to Freshdesk tickets.
  - `/api/products`: Lists available products (with optional category filter).
  - `/api/product/{model_number}`: Gets details for a specific product.

### server/app/routers/health.py
- **Health check endpoint** (`/health`).
- Returns status of all services (database, Gemini, Freshdesk, orchestrator).

### server/data/
- **metadata_manifest.json**: Media and document metadata for products.
- **Product-2025-11-12.xlsx**: Product catalog/specifications.

---

## 4. Service Initialization (Startup)
- On startup, `main.py` loads environment variables and initializes:
  - **ProductDatabase** (loads all data into memory)
  - **GeminiService** (sets up LLM and file search)
  - **FreshdeskService** (if credentials are provided)
  - **Orchestrator** (connects all services)
- If any required service fails, startup is aborted with an error.

---

## 5. API Endpoints (Summary)
- **/api/chat**: Main query endpoint (returns answer, media, sources)
- **/api/freshdesk**: Export answer to Freshdesk ticket
- **/api/products**: List products (optionally by category)
- **/api/product/{model_number}**: Get product details
- **/health**: Health check for all services

---

## 6. Data Flow Example
1. User asks: "How do I install the GC-303-T clamp?"
2. Extraction finds model number: GC-303-T
3. Retrieval gets specs/media from in-memory data, and file search returns relevant manual excerpts
4. Synthesis sends all context to Gemini LLM, which generates a markdown answer
5. Formatting packages the answer, media, and sources for the frontend

---

## 7. Error Handling & Health
- All major steps have try/except blocks and print errors to the console.
- The `/health` endpoint reports the status of each service for easy debugging.

---

## 8. Extending the Server
- To add new data fields, update the Excel/JSON files and adjust `data_loader.py`.
- To add new endpoints, create new functions in `api.py` or new routers.
- To change LLM behavior, update prompts in `prompts.py`.

---

This document should help you understand the server-side implementation, workflow, and how to extend or debug the backend of the Agent Assist Console.
