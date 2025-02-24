@echo off
REM build_all.bat - Build the APK using Docker and log output

REM Check if Docker is installed
docker --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo Docker is not installed. Please install Docker Desktop for Windows.
    pause
    exit /b 1
)

echo Building custom Docker image (mybuildozer)...
docker build --no-cache -t mybuildozer .
IF ERRORLEVEL 1 (
    echo Docker image build failed.
    pause
    exit /b 1
)
echo Docker image built successfully.
echo Current directory: %cd%

echo Starting APK build using the custom Docker image...
REM Use Git Bash to run the Docker command with a Windows-style path.
bash -c "docker run --rm -v \"%cd%\":/home/buildozer/yourproject mybuildozer"
IF ERRORLEVEL 1 (
    echo APK build failed. Please check the output above.
    pause
    exit /b 1
) ELSE (
    echo APK build succeeded! The APK file should be in the bin folder.
)
pause
