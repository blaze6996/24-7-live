# Use a newer Ubuntu version with Python 3.9+
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV VIDEO_URL="https://www.youtube.com/watch?v=Eba6OYQgRvA"  
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
RUN pip3 install -U yt-dlp flask

# Create a directory for the video
WORKDIR /app

# Copy the stream script and health check script
COPY stream.sh /app/stream.sh
COPY health_check.py /app/health_check.py

# Copy cookies.txt into the container (optional)
COPY cookies.txt /app/cookies.txt

# Give execute permissions to the script
RUN chmod +x /app/stream.sh

# Expose port 8000 for health checks
EXPOSE 8000

# Start both the streaming script and health check server
CMD bash -c "/app/stream.sh & python3 /app/health_check.py"
