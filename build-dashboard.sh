#!/bin/bash

# Build script for integrating pi-splay dashboard into jb
# This script builds pi-splay and copies it to the dashboard directory

set -e

echo "Building pi-splay dashboard..."

# Navigate to dashboard-source directory
cd dashboard-source

# Check if node_modules exists, if not install dependencies
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

# Build the dashboard
echo "Building dashboard..."
npm run build

# Go back to root
cd ..

# Remove old dashboard files
echo "Cleaning old dashboard files..."
rm -rf dashboard/*

# Copy built files
echo "Copying built files..."
cp -r dashboard-source/dist dashboard/
cp dashboard-source/index.html dashboard/index.html

# Inject analytics script
echo "Injecting analytics script..."
ANALYTICS_SCRIPT='    <script defer src="https://analytics.stashbot.app/script.js"
            data-website-id="99f9efc4-7295-464b-b9ed-7cb0ce628107"></script>'

# Use Python to inject the script (works on both macOS and Linux)
python3 << 'PYTHON_EOF'
import sys

analytics_script = '''    <script defer src="https://analytics.stashbot.app/script.js"
            data-website-id="99f9efc4-7295-464b-b9ed-7cb0ce628107"></script>'''

with open('dashboard/index.html', 'r') as f:
    content = f.read()

# Find </head> and insert analytics script before it
if '</head>' in content:
    content = content.replace('</head>', analytics_script + '\n</head>')
    with open('dashboard/index.html', 'w') as f:
        f.write(content)
    print("Analytics script injected successfully")
else:
    print("Warning: </head> tag not found in index.html", file=sys.stderr)
    sys.exit(1)
PYTHON_EOF

echo "Dashboard build complete!"
echo "Files are in: dashboard/"

