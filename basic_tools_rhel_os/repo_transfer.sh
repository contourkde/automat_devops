#!/bin/bash

# ------------------------------
# HOW TO USE:
# 1. Save this script to a file, e.g., repo_transfer.sh.
# 2. Make the script executable with: chmod +x repo_transfer.sh.
# 3. Run the script with: ./repo_transfer.sh.
#
# NOTES:
# - The script will prompt you for the original repository address and the new repository address.
# - It assumes that the default branch is 'main'. If it's 'master' or something else, adjust the script accordingly.
# - Ensure you have 'git' installed and are authorized for both repositories.
# - Always review and understand scripts you run.
# ------------------------------

# Prompt for the original repo address and clone it
read -p "Enter the original GitHub repository address to clone: " original_repo_address
git clone "$original_repo_address"
folder_name=$(basename "$original_repo_address" .git) # Determine the folder name from the repo address
cd "$folder_name"

# Rename the original repo's remote name
git remote rename origin old-origin

# Prompt for the new repo address and set it as the new origin
read -p "Enter the new GitHub repository address to push to: " new_repo_address
git remote add origin "$new_repo_address"

# Push the code to the new repo
git push origin main

echo "Repository has been cloned and pushed to the new repository."
