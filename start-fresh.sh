#!/bin/bash
# Script to start fresh with no commit history

echo "=========================================="
echo "Starting Fresh Repository (No History)"
echo "=========================================="
echo ""
echo "This will:"
echo "1. Remove all commit history"
echo "2. Create a new initial commit with current files"
echo "3. Prepare for push to CarlosSafe account"
echo ""
read -p "Continue? (y/n): " -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 1
fi

# Check if repository name is provided
if [ -z "$1" ]; then
    echo "Usage: ./start-fresh.sh REPOSITORY_NAME"
    echo ""
    echo "Example: ./start-fresh.sh Stirling-PDF-MIT"
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

# Backup current branch name
CURRENT_BRANCH=$(git branch --show-current)
echo "Current branch: $CURRENT_BRANCH"
echo ""

# Remove old remote
echo "Removing old remote..."
git remote remove origin 2>/dev/null || echo "No origin remote to remove"
echo ""

# Create orphan branch (no history)
echo "Creating new orphan branch..."
git checkout --orphan fresh-start
echo ""

# Remove all files from staging (they're still in working directory)
echo "Clearing staging area..."
git rm -rf --cached . 2>/dev/null || true
echo ""

# Add all current files
echo "Staging all current files..."
git add .
echo ""

# Create initial commit
echo "Creating initial commit..."
git commit -m "Initial commit: MIT-compliant Stirling-PDF

- Removed all proprietary code
- Updated to pure MIT license
- All proprietary security features removed
- Ready for commercial redistribution"
echo ""

# Remove old branches (optional - keeps main branch as backup)
echo "Old branches preserved. You can delete them later if needed."
echo ""

# Set up new remote
echo "Setting up remote for CarlosSafe account..."
git remote add origin "git@github-account2:${GITHUB_USER}/${REPO_NAME}.git"
echo ""

echo "=========================================="
echo "✅ Fresh repository created!"
echo "=========================================="
echo ""
echo "Current status:"
git status --short | head -10
echo ""
echo "Remote configured:"
git remote -v
echo ""
echo "=========================================="
echo "Next steps:"
echo "=========================================="
echo ""
echo "1. Test SSH connection:"
echo "   ssh -T git@github-account2"
echo ""
echo "2. Push to CarlosSafe account:"
echo "   git push -u origin fresh-start"
echo ""
echo "   Or rename branch to main first:"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "3. Verify on GitHub:"
echo "   https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo ""

