FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Install required system dependencies: Node.js, npm, and Tesseract OCR
RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs tesseract-ocr libtesseract-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy required files
COPY main.py ./
COPY requirements.txt ./

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Expose the FastAPI port
EXPOSE 8000

# Command to run the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
