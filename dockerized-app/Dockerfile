# Use an official Python runtime as a parent image
FROM python:3.7-slim AS builder

# Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /build

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install --prefix=/install --no-cache-dir -r requirements.txt

# Final stage
FROM python:3.7-slim AS runtime

# Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*
# Copy installed Python packages from the builder stage
COPY --from=builder /install /usr/local

# Copy application code
COPY . .

# Create a non-root user to run the application
RUN groupadd --system appgroup && useradd --system --gid appgroup --create-home appuser \
    && chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose the application port
EXPOSE 8000

# Healthcheck to monitor the application
HEALTHCHECK --interval=2m --timeout=10s --start-period=10s \
    CMD curl -f http://localhost:8000/ || exit 1

# Define the entrypoint and default command
ENTRYPOINT [ "python3" ]

# Run the Django development server
CMD [ "manage.py", "runserver", "0.0.0.0:8000"]