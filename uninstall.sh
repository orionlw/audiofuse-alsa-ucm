#!/bin/bash
# Removes the Arturia AudioFuse UCM profile.
set -e
UCM=/usr/share/alsa/ucm2/USB-Audio
rm -f "$UCM/Arturia/Audiofuse.conf" "$UCM/Arturia/Audiofuse-HiFi.conf"
sed -i "/1c75:af02/d" "$UCM/USB-Audio.conf"
echo "Removed. Now run (as your user): systemctl --user restart wireplumber pipewire pipewire-pulse"
