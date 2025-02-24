#!/bin/bash
# build_local_docker.sh - Script to build the APK using your custom Docker image

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker Desktop for Windows."
    exit 1
fi

echo "Building custom Docker image (mybuildozer)..."
docker build -t mybuildozer .

if [ $? -ne 0 ]; then
    echo "Docker image build failed."
    exit 1
fi

echo "Starting APK build using the custom Docker image..."

# Use $(pwd) to pass the absolute path to Docker
docker run --rm -v "$(pwd)":/home/buildozer/yourproject mybuildozer

if [ $? -eq 0 ]; then
    echo "APK build successful! The APK file is located in the 'bin' directory."
else
    echo "APK build failed. Please check the error messages above."
    exit 1
fi
