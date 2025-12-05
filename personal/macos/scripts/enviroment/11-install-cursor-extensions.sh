#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [12] INSTALLING CURSOR EXTENSIONS ==="
echo "=============================================="

# Find the correct cursor executable
CURSOR_CMD=""
if command -v cursor &> /dev/null; then
  # Check if the cursor command is actually executable
  if cursor --version &> /dev/null; then
    CURSOR_CMD="cursor"
  fi
fi

# Try alternative paths if cursor command doesn't work
if [ -z "$CURSOR_CMD" ]; then
  if [ -f "/Applications/Cursor.app/Contents/Resources/app/bin/cursor" ] && \
     /Applications/Cursor.app/Contents/Resources/app/bin/cursor --version &> /dev/null; then
    CURSOR_CMD="/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
  elif [ -f "/Applications/Cursor.app/Contents/MacOS/Cursor" ] && \
       /Applications/Cursor.app/Contents/MacOS/Cursor --version &> /dev/null; then
    CURSOR_CMD="/Applications/Cursor.app/Contents/MacOS/Cursor"
  fi
fi

if [ -z "$CURSOR_CMD" ]; then
  echo "❌ Cursor is not installed or not found"
  echo "   Please install Cursor manually from: https://cursor.sh"
  exit 1
fi

echo "Using Cursor: $CURSOR_CMD"
$CURSOR_CMD --version 2>/dev/null || echo "⚠️  Version check failed, but continuing..."

echo ""
EXTS=(
  "naumovs.color-highlight"
  "mikestead.dotenv"
  "dbaeumer.vscode-eslint"
  "eamodio.gitlens"
  "shd101wyy.markdown-preview-enhanced"
  "Prisma.prisma"
  "sainoba.px-to-rem"
  "natqe.reload"
  "bradlc.vscode-tailwindcss"
  "oderwat.indent-rainbow"
  "castrogusttavo.symbols"
  "catppuccin.catppuccin-vsc"
)

for ext in "${EXTS[@]}"; do
  echo "→ Installing: $ext"
  $CURSOR_CMD --install-extension "$ext" 2>&1 | grep -v "XML\|Error\|Access" || echo "⚠ Failed to install $ext (ignoring)"
done

echo ""
echo "All extensions attempted."

echo "=============================================="
echo "============== [12] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 12-configure-cursor.sh"

