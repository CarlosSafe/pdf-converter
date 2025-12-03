#!/bin/bash
# Script to set up repository for CarlosSafe GitHub account

echo "=========================================="
echo "Setting up repository for CarlosSafe account"
echo "=========================================="
echo ""

# Check if repository name is provided
if [ -z "$1" ]; then
    echo "Usage: ./setup-carlossafe.sh REPOSITORY_NAME"
    echo ""
    echo "Example: ./setup-carlossafe.sh Stirling-PDF-MIT"
    echo ""
    echo "First, create the repository on GitHub:"
    echo "1. Go to: https://github.com/new"
    echo "2. Log in as CarlosSafe"
    echo "3. Create repository (don't initialize with files)"
    echo "4. Then run this script with the repository name"
    exit 1
fi

REPO_NAME=$1
GITHUB_USER="CarlosSafe"

echo "Repository name: $REPO_NAME"
echo "GitHub account: $GITHUB_USER"
echo ""

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "Error: Not a git repository"
    exit 1
fi

# Check current remote
echo "Current remote:"
git remote -v
echo ""

# Update remote URL
echo "Updating remote to CarlosSafe account..."
git remote set-url origin "git@github-account2:${GITHUB_USER}/${REPO_NAME}.git"

echo ""
echo "New remote:"
git remote -v
echo ""

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "You have uncommitted changes. Would you like to commit them now? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo ""
        echo "Staging all changes..."
        git add .
        
        echo "Committing changes..."
        git commit -m "Remove proprietary code and make MIT-compliant

- Removed app/proprietary/ directory
- Updated build configuration
- Removed proprietary references from codebase
- Updated LICENSE to pure MIT
- All proprietary security features removed"
        
        echo ""
        echo "✅ Changes committed!"
    else
        echo "Skipping commit. You can commit later with:"
        echo "  git add ."
        echo "  git commit -m 'Your message'"
    fi
else
    echo "No uncommitted changes found."
fi

echo ""
echo "=========================================="
echo "Next steps:"
echo "=========================================="
echo ""
echo "1. Test SSH connection:"
echo "   ssh -T git@github-account2"
echo ""
echo "2. Push to CarlosSafe account:"
echo "   git push -u origin main"
echo ""
echo "3. Verify on GitHub:"
echo "   https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo ""

