#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [14] INSTALLING DOCKER ============="
echo "=============================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew is required. Please install it first."
  exit 1
fi

echo "Installing Docker Desktop via Homebrew..."
if ! brew list --cask docker &> /dev/null; then
  brew install --cask docker
  echo "✓ Docker Desktop installed"
else
  echo "✓ Docker Desktop already installed"
fi

echo "Starting Docker Desktop..."
open -a Docker

echo "Waiting for Docker to start..."
sleep 5

echo "Testing Docker..."
if docker ps &> /dev/null; then
  echo "✓ Docker is running"
  docker run hello-world || true
else
  echo "⚠️  Docker Desktop is starting. Please wait for it to fully start."
  echo "   You can check the status in the Docker Desktop app."
fi

echo "=============================================="
echo "============== [14] DONE ===================="
echo "=============================================="
echo "⚠️  Make sure Docker Desktop is running"
echo ""
echo "▶ Next, run: bash 15-configure-terminal.sh (final step)"

