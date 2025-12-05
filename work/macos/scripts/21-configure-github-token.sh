#!/usr/bin/env bash

set -e

WORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ENV_FILE="$WORK_DIR/.env"

if [ -f "$ENV_FILE" ]; then
    set -a
    source "$ENV_FILE"
    set +a
fi

COMPANY_NAME="${COMPANY_NAME:-your company}"

echo "=============================================="
echo "===== [22] CONFIGURING GITHUB TOKEN =========="
echo "=============================================="

echo "This script will help you configure the GITHUB_TOKEN"
echo "environment variable needed for private repositories in $COMPANY_NAME projects."
echo ""

# Check if token is provided as argument, environment variable, or already configured
if [ -n "$1" ]; then
    GITHUB_TOKEN_INPUT="$1"
    echo "✓ Token provided as argument"
elif [ -n "$GITHUB_TOKEN" ] && [ "$GITHUB_TOKEN" != "skip" ]; then
    # Token was provided at the beginning of installation
    GITHUB_TOKEN_INPUT="$GITHUB_TOKEN"
    echo "✓ Using GitHub token provided at installation start"
else
    # Check if already in .zshrc
    if grep -q "GITHUB_TOKEN" ~/.zshrc 2>/dev/null; then
        echo "⚠️  GITHUB_TOKEN is already configured in ~/.zshrc"
        read -p "Do you want to update it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Configuration skipped."
            exit 0
        fi
        # Remove old GITHUB_TOKEN line
        sed -i.bak '/GITHUB_TOKEN/d' ~/.zshrc
    fi
    echo ""
    echo "📝 To get a GitHub token:"
    echo "   1. Go to: https://github.com/settings/tokens"
    echo "   2. Click 'Generate new token' -> 'Generate new token (classic)'"
    echo "   3. Give it a name (e.g., '$COMPANY_NAME Development')"
    echo "   4. Select scopes: 'repo' (for private repositories)"
    echo "   5. Click 'Generate token'"
    echo "   6. Copy the token (you won't see it again!)"
    echo ""
    echo "💡 Tip: You can also pass the token as argument:"
    echo "   bash 21-configure-github-token.sh YOUR_TOKEN"
    echo ""
    read -p "Enter your GitHub token (or press Enter to skip): " GITHUB_TOKEN_INPUT
fi

if [ -z "$GITHUB_TOKEN_INPUT" ]; then
    echo "⚠️  Configuration skipped. You can set it manually later:"
    echo "   export GITHUB_TOKEN=your_token_here"
    echo ""
    echo "Or add to ~/.zshrc:"
    echo "   echo 'export GITHUB_TOKEN=your_token_here' >> ~/.zshrc"
    exit 0
fi

# Remove old GITHUB_TOKEN from .zshrc if exists
if grep -q "GITHUB_TOKEN" ~/.zshrc 2>/dev/null; then
    sed -i.bak '/GITHUB_TOKEN/d' ~/.zshrc
fi

# Add to .zshrc
echo "" >> ~/.zshrc
echo "# GitHub Token for private repositories" >> ~/.zshrc
echo "export GITHUB_TOKEN=\"$GITHUB_TOKEN_INPUT\"" >> ~/.zshrc

echo "✓ GITHUB_TOKEN configured in ~/.zshrc"
echo ""
echo "⚠️  IMPORTANT:"
echo "   - The token will be available after restarting the terminal"
echo "   - Or run: source ~/.zshrc"
echo "   - Keep your token secure and don't share it"
echo ""

GITHUB_ORG="${GITHUB_ORG:-your-org}"
SSO_PROJECT_NAME="${SSO_PROJECT_NAME:-sso}"
MAIN_PROJECT_NAME="${MAIN_PROJECT_NAME:-main-project}"

echo "=============================================="
echo "============== [22] DONE ===================="
echo "=============================================="
echo "🎉 $COMPANY_NAME prerequisites installation complete!"
echo ""
echo "📋 Summary of installed tools:"
echo "   ✓ .NET SDK 8"
echo "   ✓ Java 11 (OpenJDK)"
echo "   ✓ GITHUB_TOKEN configured"
echo ""
echo "📝 Next steps for $COMPANY_NAME:"
echo "   1. Clone your projects from: https://github.com/$GITHUB_ORG"
echo "   2. Set GITHUB_TOKEN: source ~/.zshrc (or restart terminal)"
echo "   3. Navigate to your project and run: yarn"
echo ""

