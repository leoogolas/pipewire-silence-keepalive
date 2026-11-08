#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME="pipewire-silence-keepalive.service"
SERVICE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
SERVICE_PATH="$SERVICE_DIR/$SERVICE_NAME"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PW_CAT_PATH="$(command -v pw-cat || true)"

if [[ -z "$PW_CAT_PATH" ]]; then
  echo "Error: pw-cat was not found."
  echo "Install the PipeWire utilities package for your distribution and try again."
  exit 1
fi

if ! command -v systemctl >/dev/null 2>&1; then
  echo "Error: systemctl was not found. This installer requires systemd."
  exit 1
fi

mkdir -p "$SERVICE_DIR"

sed "s|@PW_CAT_PATH@|$PW_CAT_PATH|g" \
  "$SCRIPT_DIR/pipewire-silence-keepalive.service" > "$SERVICE_PATH"

systemctl --user daemon-reload
systemctl --user enable --now "$SERVICE_NAME"

echo
echo "PipeWire Silence Keepalive is installed and running."
echo "Check status with:"
echo "  systemctl --user status $SERVICE_NAME"
