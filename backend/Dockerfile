FROM python:3.11-slim

# Minimal libs OpenCV needs in headless mode
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglib2.0-0 libsm6 libxext6 libxrender1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python deps first (better layer caching)
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the rest of the app
COPY . /app

# Warm EasyOCR weights so they’re baked into the image
RUN python runtime_bootstrap.py || true

EXPOSE 8080
CMD ["gunicorn", "-c", "gunicorn.conf.py", "app:app"]
