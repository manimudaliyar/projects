# Dockerized Django Application (Multi-Stage Build)

This project demonstrates how to containerize a legacy Django application using Docker and Docker Compose, focusing on real-world DevOps practices rather than application development.

The repository showcases secure containerization, multi-stage Docker builds, environment-based configuration, persistent storage with volumes, and clean orchestration using Docker Compose.

---

## Tech Stack

- Django 1.11
- Python 3.7
- Docker
- Docker Compose
- SQLite (for demonstration purposes)

---

## Project Goals

The goal of this project is to demonstrate:

- Writing production-quality Dockerfiles
- Using multi-stage builds to reduce image size
- Running containers as a non-root user
- Managing configuration through environment variables
- Persisting data using Docker volumes
- Orchestrating services with Docker Compose
- Debugging real container issues such as permissions and volume ownership

This project intentionally avoids Kubernetes and Terraform to keep the focus on Docker fundamentals.

---

## Project Structure

```
.
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── .env.example
├── manage.py
├── example
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
└── README.md

```
---

## Environment Variables

The Django application reads configuration from environment variables using `environs`.

### Required Variables

SECRET_KEY=h8+mu_iy6%5j%7+hp**+gsq$nmy!!mjd8z_qkd94@z!%9%!+qn
DEBUG=true
ALLOWED_HOSTS=localhost,127.0.0.1


- The real `.env` file is intentionally not committed
- `.env.example` is provided as a reference
- In production, environment variables are injected by the platform

---

## Docker Architecture

### Multi-Stage Docker Build

The Dockerfile uses two stages:

**Builder stage**
- Installs Python dependencies
- Includes build tools only when required
- Produces installable artifacts

**Runtime stage**
- Minimal Python base image
- Copies only runtime dependencies and application code
- Runs the application as a non-root user
- Reduced attack surface and smaller image size

---

## Architecture Overview

This project follows a production-style container workflow.

The Django application image is built separately and pushed to Amazon ECR.
The `docker-compose.yml` file does **not** build the image locally. Instead, it pulls a prebuilt, versioned image from ECR.

This mirrors real-world deployment practices where:
- Images are built once in CI
- Images are immutable artifacts
- Runtime environments only pull and run trusted image versions

---

## Security Considerations

- Application runs as a non-root user
- File permissions are explicitly managed
- No secrets are baked into the image
- Configuration is injected at runtime

---

## Volumes

SQLite database data is persisted using a Docker-managed volume:

sqlite-data:/app/db.sqlite3

The SQLite database file is mounted directly to ensure write permissions when running as a non-root user.


This ensures data survives container restarts and rebuilds.

---

## Health Check

A Docker health check is configured to verify the application is responding:

```
curl -f http://localhost:8000/ || exit 1
```

Docker marks the container as unhealthy if the application stops responding.

---

## How to Run the Application

### Prerequisites

- Docker
- Docker Compose (v2)

### Steps

1. Create a `.env` file using `.env.example` as reference
2. Run the application:
docker compose --build

3. Open the application in your browser:
http://localhost:8000


---

## Notes on Design Decisions

- SQLite is used for simplicity and learning purposes  
- In production, this would be replaced with PostgreSQL or MySQL  
- Django development server is used intentionally  
- Multi-stage builds demonstrate build-time vs runtime separation  
- Volumes and non-root users are handled explicitly

---

## Common Issues Addressed

This project intentionally covers real container issues such as:

- Permission errors with volumes
- Running containers as non-root users
- SQLite behavior inside containers
- Docker build caching
- Environment variable injection
- Health check failures

---

## Future Improvements

- Replace SQLite with PostgreSQL
- Add CI pipeline for Docker image builds
- Switch runtime to Gunicorn
- Add image size checks in CI

---

## Summary

This project demonstrates practical DevOps containerization skills:

- Clean and secure Dockerfiles
- Effective Docker Compose usage
- Understanding container lifecycle and persistence
- Debugging real-world Docker issues

This repository is designed as a resume-ready DevOps project focused on correctness, clarity, and production-aligned practices.

---

## What This Project Demonstrates

- Ability to containerize legacy applications
- Understanding of build-time vs runtime concerns
- Secure container execution as non-root
- Practical handling of volumes and filesystem permissions
- Real-world debugging of Docker and Django behavior
- Production-aligned Docker Compose workflows

---

## Author

Built as a hands-on DevOps learning project with an emphasis on real-world container behavior and best practices.
