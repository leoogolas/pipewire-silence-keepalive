# PipeWire Silence Keepalive

A small systemd user service that keeps a silent audio stream active through PipeWire.

This can help prevent audible static or noise from speakers and audio devices that produce noise when the audio stream becomes idle or the device enters a low-power state.

## Requirements

- Linux with PipeWire
- `pw-cat` available in PATH
- A running user audio session

Tested command on Bazzite:

```bash
pw-cat --playback --raw --rate 48000 --channels 2 --format s16 /dev/zero
```

The command continuously sends digital silence (zero-valued PCM samples). It does not play a tone, music, or other audible content.

## Install

Clone the repository and run the installer:

```bash
git clone https://github.com/leoogolas/pipewire-silence-keepalive.git
cd pipewire-silence-keepalive
bash install.sh
```

The installer creates a systemd user service, enables it, and starts it immediately. The service starts automatically when you log in.

## Check status

```bash
systemctl --user status pipewire-silence-keepalive.service
```

Follow its logs:

```bash
journalctl --user -u pipewire-silence-keepalive.service -f
```

## Stop or disable

Stop it temporarily:

```bash
systemctl --user stop pipewire-silence-keepalive.service
```

Start it again:

```bash
systemctl --user start pipewire-silence-keepalive.service
```

Disable automatic startup:

```bash
systemctl --user disable --now pipewire-silence-keepalive.service
```

## Uninstall

From the cloned repository directory, run:

```bash
bash uninstall.sh
```

This stops and disables the service and removes its user service file.

## Important notes

- This is a workaround, not a hardware repair. It may not fix noise caused by grounding, interference, cables, amplifiers, or defective hardware.
- The service keeps an audio stream open continuously. This may prevent some devices from entering their idle or power-saving state.
- The service does not change system volume or mute settings.
- If the service does not help, disable it with `systemctl --user disable --now pipewire-silence-keepalive.service`.

## License

MIT
