#!/usr/bin/env bash

set -e

echo "=============================================="
echo "======= [20] CONFIGURING AWS SSO ============="
echo "=============================================="

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please run 19-install-aws-cli.sh first."
    exit 1
fi

echo "Configuring AWS SSO..."
echo ""

# Check if already configured
if [ -f "$HOME/.aws/config" ] && grep -q "\[profile default\]" "$HOME/.aws/config" && grep -q "sso_start_url" "$HOME/.aws/config"; then
    echo "⚠️  AWS SSO appears to be already configured."
    read -p "Do you want to reconfigure? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Configuration skipped."
        exit 0
    fi
    # Backup existing config
    if [ -f "$HOME/.aws/config" ]; then
        cp "$HOME/.aws/config" "$HOME/.aws/config.backup.$(date +%Y%m%d_%H%M%S)"
        echo "✓ Existing config backed up"
    fi
fi

# Create .aws directory if it doesn't exist
mkdir -p "$HOME/.aws"

# Configure AWS SSO
echo "Setting up AWS SSO configuration..."
cat > "$HOME/.aws/config" << 'EOF'
[default]
sso_session = default
sso_start_url = https://letscode-aws-sso.awsapps.com/start
sso_region = sa-east-1
sso_account_id = 497769010194
sso_role_name = dev_access_devops
region = sa-east-1
output = json

[sso-session default]
sso_start_url = https://letscode-aws-sso.awsapps.com/start
sso_region = sa-east-1
EOF

echo "✓ AWS SSO configuration created"
echo ""
echo "Configuration details:"
echo "  - SSO Start URL: https://letscode-aws-sso.awsapps.com/start"
echo "  - SSO Region: sa-east-1"
echo "  - Account: DevOps (497769010194)"
echo "  - Role: dev_access_devops"
echo "  - Default Region: sa-east-1"
echo "  - Output Format: json"
echo ""

echo "=============================================="
echo "============== [20] DONE ===================="
echo "=============================================="
echo ""
echo "📝 Next steps:"
echo ""
echo "1. Login to AWS SSO:"
echo "   aws sso login"
echo ""
echo "2. Test the configuration:"
echo "   aws sts get-caller-identity"
echo ""
echo "🎉 AWS SSO configuration complete!"
