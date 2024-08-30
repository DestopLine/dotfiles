import subprocess
import logging

from i3ipc import Connection, Event
from i3ipc.events import IpcBaseEvent, WorkspaceEvent


logger = logging.getLogger(__name__)

INTL = ["setxkbmap", "us(intl)"]  # has dead keys
ALTGR_INTL = ["setxkbmap", "us(altgr-intl)"]  # doesn't have dead keys
DEFAULT = ALTGR_INTL
maps = {
    "1:dev": ALTGR_INTL,
    "2:web": INTL,
    "3:chat": INTL,
    "4:music": ALTGR_INTL,
    "5:game": INTL,
    "6:tool": INTL,
    "7:misc": INTL,
}


def main() -> None:
    logging.basicConfig(level=logging.INFO)
    conn = Connection()
    logger.info("Connected to i3")
    conn.on(Event.WORKSPACE_FOCUS, on_workspace_focus)
    conn.main()


def on_workspace_focus(_: Connection, event: IpcBaseEvent) -> None:
    assert isinstance(event, WorkspaceEvent)

    if event.current is None or event.change != "focus":
        return

    workspace = event.current.name  # type: ignore
    command = maps.get(workspace, DEFAULT)
    logger.info(f"Switched to workspace '{workspace}'; running {command}")
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    if result.returncode != 0:
        logger.error(
            f"Subprocess ended with code {result.returncode}\nCaptured stdout & stderr:\n{result.stdout}"
        )


if __name__ == "__main__":
    main()
