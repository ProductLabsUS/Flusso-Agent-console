FROM python:3.11-slim

WORKDIR /app

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend
COPY server/ ./server/

# Copy frontend
COPY client/ ./client/

EXPOSE 8080

CMD ["uvicorn", "server.app.main:app", "--host", "0.0.0.0", "--port", "8080"]
