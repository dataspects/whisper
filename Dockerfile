FROM python:3.10-slim

# Set working directory
WORKDIR /app

# System dependencies
RUN apt-get update && \
    apt-get install -y git ffmpeg build-essential curl llvm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Poetry (no virtualenvs since Docker is already isolated)
ENV POETRY_VERSION=1.8.2
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Disable Poetry virtualenvs (we're in a container already)
ENV POETRY_VIRTUALENVS_CREATE=false

# Copy dependency files
COPY pyproject.toml poetry.lock ./

# Install Python dependencies
RUN poetry install --no-root

# install whisper manually after
RUN pip install git+https://github.com/openai/whisper.git

# Copy the rest of the code
COPY . .

# Expose Flask port
EXPOSE 5000

# Run the app
CMD ["poetry", "run", "flask", "run", "--host=0.0.0.0"]
