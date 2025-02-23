# Use Ubuntu as base image
FROM ubuntu:latest

# Set maintainer (optional)
LABEL maintainer="your-email@example.com"

# Install basic dependencies
RUN apt update && apt install -y curl wget git vim

# Copy application files (if any)
# COPY . /app

# Set working directory
WORKDIR /app

# Default command to keep container running
CMD ["echo", "Hello from my Docker container!"]
