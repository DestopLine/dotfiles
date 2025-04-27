import json
import logging
import os
import socket
import subprocess

logger = logging.getLogger(__name__)

INTL = 0  # us(intl) has dead keys
ALTGR_INTL = 1  # us(altgr-intl) doesn't have dead keys
DEFAULT_LAYOUT = ALTGR_INTL
layouts = {
    1: ALTGR_INTL,
    2: INTL,
    3: INTL,
    4: ALTGR_INTL,
    5: INTL,
    6: INTL,
    7: INTL,
}


def main() -> None:
    logging.basicConfig(level=logging.INFO)
    signature = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE")
    if signature is None:
        logger.error("HYPRLAND_INSTANCE_SIGNATURE not set")
        exit(1)
    xdg_runtime_dir = os.environ.get("XDG_RUNTIME_DIR")
    if signature is None:
        logger.error("XDG_RUNTIME_DIR not set")
        exit(1)

    socket_path = f"{xdg_runtime_dir}/hypr/{signature}/.socket2.sock"
    
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as client:
        client.connect(socket_path)
        client_file = client.makefile("r")

        while True:
            line = client_file.readline().strip()
            if line.startswith("activewindow>>"):
                try:
                    # Get active workspace ID via hyprctl
                    result = subprocess.run(["hyprctl", "activeworkspace", "-j"], capture_output=True, text=True)
                    workspace_data = json.loads(result.stdout)
                    ws_id: int = workspace_data.get("id")

                    layout = layouts.get(ws_id, DEFAULT_LAYOUT)
                    logger.info("Switching to layout '%s' for workspace %s", layout, str(ws_id))
                    subprocess.run(["hyprctl", "switchxkblayout", "current", str(layout)])

                except Exception as e:
                    logger.error("Error handling workspace switch: %s", e)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        logger.debug("Exiting by keyboard interrupt")
        exit(0)

