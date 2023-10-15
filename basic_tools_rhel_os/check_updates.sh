#!/bin/bash

# ------------------------------
# HOW TO USE:
# 1. Save this script to a file, e.g., check_updates.sh.
# 2. Make the script executable with: chmod +x check_updates.sh.
# 3. Run the script with: ./check_updates.sh.
#
# NOTES:
# - The script checks if 'git' is up-to-date using 'dnf'.
# - The script checks if 'gcloud' is up-to-date using 'gcloud components update'.
# - Ensure you have both 'git' and 'gcloud' installed before running.
# - Always review and understand scripts you run.
# ------------------------------

# Check for 'git' updates
echo "Checking if 'git' is up-to-date..."
if sudo dnf check-update git | grep -q "git"; then
    echo "'git' has updates available. Consider updating using 'sudo dnf update git'."
else
    echo "'git' is up-to-date."
fi

# Check if 'gcloud' CLI is installed
if ! command -v gcloud &> /dev/null; then
    echo "'gcloud' command not found. Please install the Google Cloud SDK."
    exit 1
fi

# Check for 'gcloud' updates
echo "Checking if 'gcloud' is up-to-date..."
gcloud_components_output=$(gcloud components list --format="get(state.name)")

if echo "$gcloud_components_output" | grep -q "Update available"; then
    echo "'gcloud' has updates available. Consider updating using 'gcloud components update'."
else
    echo "'gcloud' is up-to-date."
fi
