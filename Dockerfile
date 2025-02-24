FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages including cython
RUN apt-get update && apt-get install -y \
    python3-pip python3-dev build-essential git ccache libffi-dev libssl-dev libjpeg8-dev zlib1g-dev \
    openjdk-8-jdk unzip wget cython && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Buildozer
RUN pip3 install --upgrade pip && pip3 install buildozer

# Set the working directory
WORKDIR /home/buildozer/yourproject

# Use a shell command to automatically pipe "y" into Buildozer
CMD ["sh", "-c", "echo y | buildozer --allow-root -v android debug"]
