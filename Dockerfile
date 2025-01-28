# Use a base image with ffmpeg and other dependencies
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV VIDEO_URL="https://www.youtube.com/watch?v=skd8agKL-C0"  
ENV STREAM_KEY="wgz4-pbmt-5hg5-v9tz-7heq" 

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

# Copy cookies.txt into the container (make sure to provide the correct path to the cookies file)
COPY cookies.txt /app/cookies.txt

# Give execute permissions to the script
RUN chmod +x /app/stream.sh

# Set the default command to run the script
CMD ["/bin/bash", "/app/stream.sh"]
