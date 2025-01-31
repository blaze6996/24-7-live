# Use a base image with ffmpeg and other dependencies
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV VIDEO_URL="https://www.youtube.com/watch?v=2m9qcUij7AY?"
ENV STREAM_KEY="jhg1-2h8u-gd02-e45t-bj9j"

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    ffmpeg \
    curl \
    bash \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install yt-dlp (youtube-dl replacement)
RUN pip3 install -U yt-dlp

# Install Gunicorn
RUN pip3 install gunicorn

# Create a directory for the video
WORKDIR /app

# Copy the stream.sh script into the container
COPY stream.sh /app/stream.sh

# Copy cookies.txt into the container (make sure to provide the correct path to the cookies file)
COPY cookies.txt /app/cookies.txt

COPY app.py /app.py

# Give execute permissions to the script
RUN chmod +x /app/stream.sh

# Add a health check to verify that the Flask app is running
HEALTHCHECK CMD curl --fail http://localhost:8000/health || exit 1

# Set the default command to use Gunicorn for serving the Flask app
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]

