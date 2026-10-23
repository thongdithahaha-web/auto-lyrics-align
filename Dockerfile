FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libsndfile1 \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install PyTorch CPU and Python packages
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir torch torchaudio --index-url https://download.pytorch.org/whl/cpu && \
    pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Expose port (7860 is default for Hugging Face Spaces, or set by PORT env)
ENV PORT=7860
EXPOSE 7860

CMD ["python", "backend/fastapi_app.py"]
