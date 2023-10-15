#!/bin/bash

# ------------------------------
# HOW TO USE:
# 1. Save this script to a file, e.g., connect_gcloud.sh.
# 2. Make the script executable with: chmod +x connect_gcloud.sh.
# 3. Run the script with: ./connect_gcloud.sh.
#
# NOTES:
# - The script will guide you through authenticating with Google Cloud.
# - You'll be prompted to set a default project.
# - Ensure you have the 'gcloud' CLI installed before running this script.
# - Always review and understand scripts you run.
# ------------------------------

# Check if 'gcloud' CLI is installed
if ! command -v gcloud &> /dev/null; then
    echo "'gcloud' command not found. Please install the Google Cloud SDK."
    exit 1
fi

# Authenticate with Google Cloud
gcloud auth login

# List available projects
echo "Fetching your Google Cloud projects..."
gcloud projects list

# Set default project
read -p "Enter the PROJECT_ID to set as default: " project_id
gcloud config set project $project_id

# Confirm settings
echo "Your current gcloud configuration is:"
gcloud config list

echo "You are now connected to Google Cloud!"
