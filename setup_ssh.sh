#!/bin/bash

# ------------------------------
# HOW TO USE:
# 1. Save this script to a file, e.g., setup_ssh.sh.
# 2. Make the script executable with: chmod +x setup_ssh.sh.
# 3. Run the script with: ./setup_ssh.sh.
#
# NOTES:
# - The script will prompt you for your GitHub email address.
# - If the system doesn't support Ed25519, it will use RSA.
# - After key generation, the script will add it to the ssh-agent.
# - The public key will be displayed for you to verify.
# - The script will then attempt to add the key to your GitHub account using the 'gh' CLI.
# - Always review and understand scripts you run, especially when handling SSH keys.
# ------------------------------

# Prompt for email
read -p "Enter your GitHub email address: " email

# Determine whether to use Ed25519 or RSA based on system support
if [[ $(ssh-keygen -t ed25519 -f /dev/null -N "" 2>&1) == *"unknown key type"* ]]; then
    echo "Your system does not support Ed25519. Using RSA instead."
    key_type="rsa"
    key_bits="-b 4096"
else
    echo "Using Ed25519 for SSH key generation."
    key_type="ed25519"
    key_bits=""
fi

# Generate SSH key
key_path="$HOME/.ssh/id_$key_type"
ssh-keygen -t $key_type $key_bits -C "$email"

# Add the key to ssh-agent
eval "$(ssh-agent -s)"
ssh-add $key_path

# Display public key for verification
echo "------------------"
echo "Here's your SSH public key for verification:"
cat $key_path.pub
echo "------------------"

# Add the SSH key to the GitHub account using 'gh' CLI
if command -v gh &> /dev/null; then
    gh ssh-key add $key_path.pub --title "$(hostname)"
    echo "SSH key added to your GitHub account successfully!"
else
    echo "GitHub CLI ('gh') not found. Please manually add the displayed SSH public key to your GitHub account."
fi
