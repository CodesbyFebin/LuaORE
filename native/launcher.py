#!/usr/bin/env python3
"""OreBunker native Luanti launcher with per-mode worlds. Python 3.9+."""
from __future__ import annotations
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
GAME = ROOT / "orebunker"
MODES = {"survival", "creative", "ore-hunt", "rig-network"}
def detect():
    override = os.environ.get("LUANTI_BIN")
    candidates = [override] if override else []
    candidates += [shutil.which("luanti"), shutil.which("minetest")]
    if sys.platform == "darwin":
        candidates += ["/Applications/Luanti.app/Contents/MacOS/luanti",
                       "/Applications/Luanti.app/Contents/MacOS/minetest"]
    for raw in candidates:
        if raw and Path(raw).is_file() and os.access(raw, os.X_OK):
            return str(Path(raw).resolve())
    raise SystemExit("Luanti not installed. Set LUANTI_BIN to its executable.")
def stage(mode, data):
    data.mkdir(parents=True, exist_ok=True)
    games = data / "games"
    games.mkdir(exist_ok=True)
    dest = games / "orebunker"
    if dest.exists():
        shutil.rmtree(dest)
    shutil.copytree(GAME, dest)
    world = data / "worlds" / ("orebunker_" + mode.replace("-", "_"))
    world.mkdir(parents=True, exist_ok=True)
    (world / "world.mt").write_text("gameid = orebunker\nbackend = sqlite3\n", encoding="utf-8")
    conf = data / ("mode_" + mode + ".conf")
    conf.write_text(
        "name = OreBunker\nserver_announce = false\n"
        + "creative_mode = " + ("true" if mode == "creative" else "false") + "\n"
        + "orebunker_mode = " + mode + "\n",
        encoding="utf-8",
    )
    return world, conf
def main():
    parser = argparse.ArgumentParser(description="OreBunker native Luanti game launcher")
    parser.add_argument("--mode", choices=sorted(MODES), default="survival")
    parser.add_argument("--data", type=Path, default=Path.home() / ".luaore-orebunker")
    parser.add_argument("--server", action="store_true")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    world, conf = stage(args.mode, args.data.expanduser())
    if args.dry_run:
        print(f"Mode: {args.mode}\nWorld: {world}\nConfig: {conf}\nGame: {args.data / 'games/orebunker'}")
        return
    engine = detect()
    cmd = [engine, "--config", str(conf), "--world", str(world)]
    if args.server:
        cmd += ["--server"]
    else:
        cmd += ["--go"]
    os.execv(engine, cmd)
if __name__ == "__main__":
    main()
