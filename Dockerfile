FROM python:3.11-slim

LABEL maintainer="@jay_townsend1 & @NotoriousRebel1"

RUN useradd -m -u 1000 -s /bin/bash theharvester

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir uv
RUN UV_PROJECT_ENVIRONMENT=/usr/local uv sync --locked --no-dev --no-cache

USER theharvester

EXPOSE 80

ENTRYPOINT ["restfulHarvest", "-H", "0.0.0.0", "-p", "80"]
