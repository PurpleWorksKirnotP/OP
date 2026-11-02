# Purp's Scripts

> Roblox scripts, Python and PowerShell tools — all open source, so you can read
> exactly what you are running before you run it.

**Discord:** `kirturneedpurp`

Source is public so anyone can read what these scripts do. Usage and redistribution
follow [LICENSE.md](LICENSE.md): personal use and modification are fine, reposting
anywhere other than rscripts.net needs my permission.

With that being said, enjoy! <3

---

## Contents

| Folder | What's in it | State |
| --- | --- | --- |
| [`Suitborn/`](Suitborn/README.md) | Suitborn (Night 1) and Waterbath | in the repo, re-test after a game update |
| [`PurpsUtility/`](PurpsUtility/README.md) | All-in-one hub, Aimlock V1 / V2 / BETA | V2 and BETA current, V1 retired |
| [`PurpsScripts/`](PurpsScripts/README.md) | Hekmatyar (dirty money) and friends | WIP |
| [`Mains/`](Mains/CmdPurps.md) | Python and PowerShell tools, plus the guides | see the guide |
| [`Borrowed(STOLEN)Scripts/`](<Borrowed(STOLEN)Scripts/README.md>) | scripts I found interesting | not mine — read the original source |
| [`Misc/`](Misc/MinecraftHax/README.md) | PurpsClient (a Wurst build) | third-party, GPLv3 |

## Roadmap

An all-in-one hub for all of my scripts (Suitborn, PurpsScripts, PurpsUtil, you name
it!) is coming soon.

EscapeEarly and Gojira are going to be retired and integrated into the Suitborn
Night 1 script, so stay tuned!

## Requirements

| For | You need |
| --- | --- |
| **Roblox scripts** | nothing to install — paste the `loadstring` one-liner into an executor that supports `loadstring` and `game:HttpGet` (see each folder's README for the exact requirements of that script) |
| **Python tools** | one dependency, see below |
| **PowerShell tools** | Windows PowerShell 5.1+ (or `pwsh`), no modules needed |

```bash
python -m pip install -r requirements.txt
```

Build output (`dist/`, `build/`, `__pycache__/`) is ignored by git; the Windows exe
is no longer committed — see [the build steps](Mains/CmdPurps.md#building-the-windows-exe).

## Safety notes

- Nothing in this repo collects passwords or personal data. The old `PSEncrypt`
  tool, which asked for a password and posted it to a Discord webhook, has been
  removed.
- No Discord webhook URLs are stored here any more. Scripts that need one read it
  from `$env:DISCORD_WEBHOOK_URL` or ask you for it.
- No script installs itself into your Startup folder, disables your network
  adapters or shuts your PC down.
- The "hacking" tools (`NH.py`, `KSPOR.py`, CMF) are **simulations** — they print
  generated text for fun. They do not attack, scan, infect or mine anything.

## Remote code in the Roblox scripts

Every Roblox script here (`EscapeEarly.lua`, `Gojira.lua`, and everything under
`Suitborn/`, `PurpsUtility/`, `PurpsScripts/` and `Borrowed(STOLEN)Scripts/`) starts
by `loadstring`-ing a file from the internet, and several of them also pull in a UI
library. Nothing is vendored, so what runs in your executor is whatever those URLs
serve at that moment — including the copies of my own scripts on `main`:

| Host | What it provides |
| --- | --- |
| `raw.githubusercontent.com/PurpleWorksKirnotP/PurpleScripts` | this repo's own scripts (EscapeEarly, Gojira, Suitborn, PurpsUtility, ...) |
| `raw.githubusercontent.com/DozeIsOkLol/UILibarys` | notification library |
| `raw.githubusercontent.com/bloodball/-back-ups-for-libs` | shared library backup |
| `raw.githubusercontent.com/EdgeIY/infiniteyield` | Infinite Yield admin commands |
| `raw.githubusercontent.com/imagoodpersond/puppyware` | aimbot library |
| `sirius.menu/rayfield` | Rayfield UI library |
| `rawscripts.net` | the "cracked"/borrowed scripts (Waterbath, Dex++, BRM5 ESP) |

These are third-party sources I do not control. Read a file before you paste a
loader, and prefer running the copy from this repo if you want to know what it does.

## "Are these Python/PowerShell scripts malware?"

You don't have to take my word for it — the source for every tool is in this repo
(read it!) and you can also run it through
[VirusTotal](https://www.virustotal.com/gui/), a completely free virus checker on the
internet. Heuristic scanners often flag "hacker tool"-looking output, so read the code
as well.

Known, deliberate behaviour of the non-Roblox tools:

| Tool | What it really does |
| --- | --- |
| `Mains/Python/NYHCKAssets/Main/NH.py` | Windows only. Asks for UAC elevation, prints simulated output, and can download its own update into `C:\Program Files\_nhprogfiles`. |
| `Mains/Python/NYHCKAssets/Main/DummedDown/NH.py` | Same, trimmed for Linux / iSH. Skips elevation outside Windows. |
| `Mains/Python/KSPOR.py` / `KSPORe.py` | Prints simulated "routing" / payload output. No networking. |
| `Mains/Powershell/CMF+0.2.6.ps1` | Prints simulated cookie-scan output. No persistence, no file access. |
| `Mains/Powershell/CMFEXTENSION+0.2.6.ps1` | Lists file names/sizes under your user profile and prints them. Read-only: nothing is changed. |
| `Mains/Python/CMFExtensionPython0.0.1.py` | Walks your home folder and prints file names/sizes with random "safety" verdicts. |

---

<sub>Read the [LICENSE](LICENSE.md) and the [DISCLAIMER](DISCLAIMER.md) before using anything here.</sub>
