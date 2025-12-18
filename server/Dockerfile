# Backend Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ ./app/
COPY data/ ./data/

# Cloud Run listens on 8080
EXPOSE 8080

# Start FastAPI (Cloud Run compatible)
CMD exec uvicorn app.main:app --host 0.0.0.0 --port $PORT
