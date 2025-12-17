#!/usr/bin/env bash
# Render build script for Agent Assist Console

echo "🚀 Starting build process..."

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip install --upgrade pip
pip install -r server/requirements.txt

echo "✅ Build complete!"
