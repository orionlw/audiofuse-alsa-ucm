#!/bin/bash
# Installs the Arturia AudioFuse (1c75:af02) UCM profile. Re-run after alsa-ucm package updates.
set -e
cd "$(dirname "$0")"
UCM=/usr/share/alsa/ucm2/USB-Audio
install -m644 Audiofuse.conf Audiofuse-HiFi.conf "$UCM/Arturia/"
if ! grep -q "1c75:af02" "$UCM/USB-Audio.conf"; then
  sed -i "/^Macro.minifuse12.RegexMatch/a Macro.audiofuse.StringMatch\t\t\"Id='1c75:af02' Profile='Arturia/Audiofuse'\"" "$UCM/USB-Audio.conf"
fi
grep -n "1c75:af02" "$UCM/USB-Audio.conf"
echo "Installed. Now run (as your user): systemctl --user restart wireplumber pipewire pipewire-pulse"
