# Use Python 3.10 as the base image
FROM python:3.10-slim

# Set environment variables for OSMesa rendering
ENV LIBGL_ALWAYS_SOFTWARE=1 \
    MESA_GL_VERSION_OVERRIDE=3.3 \
    MESA_GLSL_VERSION_OVERRIDE=330 \
    DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    libcairo2-dev \
    libpango1.0-dev \
    libpangocairo-1.0-0 \
    pkg-config \
    ffmpeg \
    git \
    libosmesa6 \
    libosmesa6-dev \
    mesa-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the ManimGL repository into the container
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install PyOpenGL PyOpenGL-accelerate

# Default command for ManimGL
CMD ["python3", "-m", "manimlib", "--help"]
