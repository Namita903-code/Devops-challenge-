FROM python:3.11-slim

# Install libcap
RUN apt-get update && apt-get install -y libcap2-bin --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app/ ./app
COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Allow non-root user to bind to port 80
RUN setcap 'cap_net_bind_service=+ep' /usr/local/bin/python3

# Create non-root user
RUN useradd -m appuser
USER appuser

EXPOSE 80

CMD ["python3", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
