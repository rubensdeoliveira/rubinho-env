#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [11] CONFIGURING FILE WATCHERS ====="
echo "=============================================="

echo "Configuring file watcher limits for macOS..."
echo ""
echo "⚠️  macOS uses different file watching mechanisms than Linux"
echo "   (kqueue instead of inotify)"
echo ""

# Increase file descriptor limits
echo "Setting file descriptor limits..."
ulimit -n 65536

# Make it persistent by adding to .zshrc
if ! grep -q "ulimit -n 65536" ~/.zshrc; then
  echo "" >> ~/.zshrc
  echo "# Increase file descriptor limit for file watchers" >> ~/.zshrc
  echo "ulimit -n 65536" >> ~/.zshrc
  echo "✓ Added ulimit to .zshrc"
fi

# For Node.js projects, you might want to set CHOKIDAR_USEPOLLING
echo ""
echo "Note: For some Node.js projects, you may need to set:"
echo "  export CHOKIDAR_USEPOLLING=true"
echo ""
echo "Or add it to your .zshrc if you experience file watching issues"

echo "=============================================="
echo "============== [11] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 11-install-cursor-extensions.sh"

