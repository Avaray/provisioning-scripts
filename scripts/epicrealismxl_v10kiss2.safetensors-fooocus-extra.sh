#!/bin/bash
set -e

# Auto-generated provisioning script for epicrealismXL_v10Kiss2 (Fooocus - Extra)
# Generated at 2026-05-06T21:21:09.943Z

function download_file() {
    local url="$1"
    local dest="$2"
    
    mkdir -p "$dest"
    cd "$dest"
    
    echo "Downloading to $dest..."
    if command -v aria2c &> /dev/null; then
        aria2c --console-log-level=error -c -x 16 -s 16 -k 1M --content-disposition "$url"
    elif command -v wget &> /dev/null; then
        wget --content-disposition -q --show-progress "$url"
    elif command -v curl &> /dev/null; then
        curl -OJL --progress-bar "$url"
    else
        echo "Error: No download utility found."
        exit 1
    fi
}

function clone_extension() {
    local url="$1"
    local dest="$2"
    
    mkdir -p "$dest"
    cd "$dest"
    
    echo "Cloning extension to $dest..."
    git clone "$url" || echo "Git clone failed, it might already exist."
    
    local repo_name=$(basename -s .git "$url")
    if [ -d "$repo_name" ] && [ -f "$repo_name/requirements.txt" ]; then
        echo "Installing requirements for $repo_name..."
        cd "$repo_name"
        if [ -f "/workspace/venv/bin/activate" ]; then
            source /workspace/venv/bin/activate
            pip install -r requirements.txt || echo "Failed to install requirements."
            deactivate || true
        else
            pip install -r requirements.txt || echo "Failed to install requirements."
        fi
    fi
}

echo "=== Starting Provisioning for epicrealismXL_v10Kiss2 ==="

# --- Base Model ---
download_file "https://huggingface.co/datasets/AddictiveFuture/sdxl-1-0-models-backup/resolve/main/CHECKPOINT/epicrealismXL_v10Kiss2.safetensors" "/workspace/Fooocus/models/checkpoints"

echo "=== Provisioning Complete ==="
