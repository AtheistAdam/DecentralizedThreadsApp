FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages for Buildozer, Android build tools, and Cython
RUN apt-get update && apt-get install -y \
    python3-pip python3-dev build-essential git ccache libffi-dev libssl-dev libjpeg8-dev zlib1g-dev \
    openjdk-8-jdk unzip wget cython && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Buildozer
RUN pip3 install --upgrade pip && pip3 install buildozer

# Patch Buildozer to bypass interactive confirmation when running as root.
# The prompt text in Buildozer is: 
#   Are you sure you want to continue [y/n]? 
# This sed command will replace that prompt with a fixed answer "y".
RUN sed -i "s/cont = input('Are you sure you want to continue \\[y\\/n\\]\\? ')/cont = 'y'/g" /usr/local/lib/python3.8/dist-packages/buildozer/__init__.py

# Set the working directory inside the container
WORKDIR /home/buildozer/yourproject

# Run Buildozer with --allow-root so that it does not prompt
CMD ["buildozer", "--allow-root", "-v", "android", "debug"]
