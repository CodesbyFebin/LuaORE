# LuaORE · OreBunker Native Game Modes

This directory is an **independent native Luanti game package**. It does not modify or rename upstream engine repositories.

Requirements: Luanti installed separately, Python 3.9+.

Run from repository root:

```bash
python3 native/launcher.py --mode survival
python3 native/launcher.py --mode creative
python3 native/launcher.py --mode ore-hunt
python3 native/launcher.py --mode rig-network
python3 native/launcher.py --mode ore-hunt --server
```

Use `--dry-run` to stage game/world/config without launching. Set `LUANTI_BIN` to an installed Luanti executable if autodetection fails.

Survival: basic native mapgen, coal, diamond, fictional ORE and Solana ores, starter pickaxe.
Creative: separate creative world configuration.
ORE Hunt: use `/obready` with two Luanti players to begin a 60-second server-scored round. Mine crystal ores for 25, coal for 3, and stone for 1 point; `/obscore` displays standings and wins.
Rig Network: use `/obrig` to inspect virtual H/s and fictional credits, then `/obbuy amethyst` or `/obbuy ember` for upgrades. Mining rigs are simulations that **never hash cryptocurrency blocks**.

Security: no ORE wallets, token issuance, Solana spending or on-chain financial transactions. Solana/ORE marks on resources are descriptive fan artwork only, not official partnership claims.

Testing status: package committed but native Luanti runtime, mapgen, world loading, multiplayer and browser UI **not verified** in this environment. The arena registers digging callbacks, but does not physically prevent crossing arena edges; scores are server-side and restricted to the 48x48 region. Rig simulation credits have no on-chain value.

Licensing: newly written native Lua/Python code is original and intended for distribution under MIT; upstream Luanti and ContentDB packages carry their own licensing conditions.
