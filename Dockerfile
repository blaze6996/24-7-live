# Use a newer Ubuntu version with Python 3.9+
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV VIDEO_URL="https://www.youtube.com/watch?v=2m9qcUij7AY"  
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

# Create a directory for the video
WORKDIR /app

# Copy the stream.sh script into the container
COPY stream.sh /app/stream.sh

# Copy cookies.txt into the container (optional)
COPY cookies.txt /app/cookies.txt

# Give execute permissions to the script
RUN chmod +x /app/stream.sh

# Set the default command to run the script
CMD ["/bin/bash", "/app/stream.sh"]
