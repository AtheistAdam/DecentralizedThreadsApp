FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages including cython
RUN apt-get update && apt-get install -y \
    python3-pip python3-dev build-essential git ccache libffi-dev libssl-dev libjpeg8-dev zlib1g-dev \
    openjdk-8-jdk unzip wget cython && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Buildozer
RUN pip3 install --upgrade pip && pip3 install buildozer

# Set the working directory inside the container
WORKDIR /home/buildozer/yourproject

# If .buildozer exists, clean it; then build the APK (pipe "y" to auto-accept licenses)
CMD ["sh", "-c", "if [ -d .buildozer ]; then echo y | buildozer android clean; fi && echo y | buildozer --allow-root -v android debug"]
