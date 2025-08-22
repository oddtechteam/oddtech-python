# Use Python 3.10 (TF 2.11, deepface compatible)
FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TF_CPP_MIN_LOG_LEVEL=2

WORKDIR /app

# Native libs for numpy/opencv
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libgl1 libglib2.0-0 \
 && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel \
 && pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Railway provides $PORT at runtime
ENV PORT=8000
EXPOSE 8000

# If your Flask entry is app.py with "app = Flask(__name__)"
#CMD ["sh","-c","gunicorn -b 0.0.0.0:${PORT} app:app"]
# If your file is main.py, change to:  main:app
