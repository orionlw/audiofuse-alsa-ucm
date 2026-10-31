# Arturia AudioFuse ALSA UCM profile

ALSA Use Case Manager (UCM) profile for the original **Arturia AudioFuse** (USB ID `1c75:af02`).

Without it, PipeWire/PulseAudio shows the interface as a single **"Analog Surround 7.1"** device,
because the AudioFuse exposes 8 playback and 8 capture channels.
(See [alsa-ucm-conf#568](https://github.com/alsa-project/alsa-ucm-conf/issues/568).)
With it, you get separate stereo and mono devices.

## Devices

**HiFi profile**

| Device | Channels | Description |
|---|---|---|
| Line1 | out 1/2 | Main / Speakers (default) |
| Line2 | out 3/4 | Output 3/4 |
| Line3 | out 5/6 | Output 5/6 |
| Line4 | out 7/8 | Output 7/8 |
| Mic1  | in 1    | Input 1 (Mic/Inst), mono |
| Mic2  | in 2    | Input 2 (Mic/Inst), mono |
| Line5 | in 1/2  | Input 1/2 stereo |
| Line6 | in 3/4  | Input 3/4 stereo (Line/Phono) |
| Line7 | in 5/6  | Input 5/6 stereo |
| Line8 | in 7/8  | Input 7/8 stereo |

**Direct profile:** all 8 in / 8 out as a single device, for DAWs.

## Install

Tested on Fedora 44 with `alsa-ucm` 1.2.16.

```sh
git clone https://github.com/<you>/audiofuse-alsa-ucm.git
cd audiofuse-alsa-ucm
sudo ./install.sh
systemctl --user restart wireplumber pipewire pipewire-pulse
```

If you still see 7.1, select the **HiFi** profile for the AudioFuse in `pavucontrol` (Configuration tab)
or in your desktop's sound settings.

> Updates to your distro's `alsa-ucm` / `alsa-ucm-conf` package overwrite `/usr/share/alsa/ucm2`.
> Re-run `sudo ./install.sh` after updating.

To validate the config: `alsaucm -c AudioFuse dump text` (Fedora package: `alsa-ucm-utils`).

## Uninstall

```sh
sudo ./uninstall.sh
systemctl --user restart wireplumber pipewire pipewire-pulse
```

## Files

- `Audiofuse.conf`, `Audiofuse-HiFi.conf`: the UCM profile (installed to `ucm2/USB-Audio/Arturia/`)
- `install.sh` / `uninstall.sh`: copy the files and register the USB ID in `ucm2/USB-Audio/USB-Audio.conf`
- `audiofuse-alsa-ucm-conf.patch`: the same change as a patch against the alsa-ucm-conf tree, for upstreaming

## Notes

Channel labels for 5–8 are generic. Corrections about how they map to the physical
S/PDIF, ADAT or headphone connectors are welcome.

## License

BSD-3-Clause, same as alsa-ucm-conf, which these files are derived from.
