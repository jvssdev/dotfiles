#!/bin/bash
set -e

echo "Setting up services..."

# zRAM
echo "Enabling zRAM..."
sudo dinitctl enable zramen
sudo dinitctl start zramen

# zRAM config 
if [ ! -f /etc/zramen.conf ]; then
    echo "Creating zRAM config..."
    cat <<EOF | sudo tee /etc/zramen.conf
ZRAM_SIZE=4096
ZRAM_STREAMS=4
ZRAM_ALGORITHM=zstd
EOF
fi

# Verifying zRAM
if swapon --show | grep -q zram; then
    echo "✓ zRAM is running!"
    swapon --show
else
    echo "✗ zRAM not active"
fi

# MPD with dinit
if [ -f /etc/dinit.d/user/mpd ]; then
    echo "Enabling MPD..."
    dinitctl --user enable mpd
    dinitctl --user start mpd
    
    if dinitctl --user status mpd | grep -q "running"; then
        echo "✓ MPD is running!"
    else
        echo "✗ MPD failed to start"
    fi
else
    echo "✗  MPD dinit service not found, skipping..."
fi

echo "✓ Setup complete!"
