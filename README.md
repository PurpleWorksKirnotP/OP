# Welcome to Purp's scripts.

---

Contact me on discord!!!
user: kirturneedpurp

Source is public so anyone can read what these scripts do. Usage and
redistribution follow [LICENSE.md](LICENSE.md): personal use and modification are
fine, reposting anywhere other than rscripts.net needs my permission.

With that being said, enjoy! <3

# Currently working on a release soon!

---

I'm going to release an all-in-one hub for all of my scripts (Suitborn, PurpsScripts, PurpsUtil, you name it!)

I'm also going to retire the EscapeEarly and Gojira luas and intergrate them with the suitborn night 1 script so stay tuned!

# Purps Scripts

---

For cmd scripts:

Jump to [Guides](Mains/CmdPurps.md)

For roblox Scripts:

Jump to [Suitborn Scripts](Suitborn/README.md) - Suitborn and Waterbath are both in the repo, but games patch fast, so re-test after a game update.

Jump to [Purps Utility Scripts](PurpsUtility/README.md) - Aimlock V2 / BETA are the current ones, V1 is retired.

Jump to [PurpsScripts](PurpsScripts/README.md) - WIP

Jump to [Borrowed Scripts](<Borrowed(STOLEN)Scripts/README.md>) - Borrowed Scripts I find Interesting.

# Requirements

---

- **Roblox scripts:** nothing to install - paste the `loadstring` one-liner into
  an executor that supports `loadstring` and `game:HttpGet` (see each folder's
  README for the exact requirements of that script).
- **Python tools:** one dependency.

  ```
  python -m pip install -r requirements.txt
  ```

- **PowerShell tools:** Windows PowerShell 5.1+ (or `pwsh`), no modules needed.
- Build output (`dist/`, `build/`, `__pycache__/`) is ignored by git; the
  Windows exe is no longer committed, see
  [the build steps](Mains/CmdPurps.md#building-the-windows-exe).

# Safety notes

---

- Nothing in this repo collects passwords or personal data. The old `PSEncrypt`
  tool, which asked for a password and posted it to a Discord webhook, has been
  removed.
- No Discord webhook URLs are stored here any more. Scripts that need one read it
  from `$env:DISCORD_WEBHOOK_URL` or ask you for it.
- No script installs itself into your Startup folder, disables your network
  adapters or shuts your PC down.
- The "hacking" tools (`NH.py`, `KSPOR.py`, CMF) are **simulations** - they print
  generated text for fun. They do not attack, scan, infect or mine anything.

# Remote code in the Roblox scripts

---

Every Roblox script here (`EscapeEarly.lua`, `Gojira.lua`, and everything under
`Suitborn/`, `PurpsUtility/`, `PurpsScripts/` and `Borrowed(STOLEN)Scripts/`)
starts by `loadstring`-ing a file from the internet, and several of them also
pull in a UI library. Nothing is vendored, so what runs in your executor is
whatever those URLs serve at that moment - including the copies of my own
scripts on `main`:

| Host | What it provides |
| --- | --- |
| `raw.githubusercontent.com/PurpleWorksKirnotP/OP` | this repo's own scripts (EscapeEarly, Gojira, Suitborn, PurpsUtility, ...) |
| `raw.githubusercontent.com/DozeIsOkLol/UILibarys` | notification library |
| `raw.githubusercontent.com/bloodball/-back-ups-for-libs` | shared library backup |
| `raw.githubusercontent.com/EdgeIY/infiniteyield` | Infinite Yield admin commands |
| `raw.githubusercontent.com/imagoodpersond/puppyware` | aimbot library |
| `sirius.menu/rayfield` | Rayfield UI library |
| `rawscripts.net` | the "cracked"/borrowed scripts (Waterbath, Dex++, BRM5 ESP) |

These are third-party sources I do not control. Read a file before you paste a
loader, and prefer running the copy from this repo if you want to know what it
does.

# To those who think my python/powershell scripts are malware:

You don't have to take my word for it - the source for every tool is in this repo
(read it!) and you can also run it through [VirusTotal](https://www.virustotal.com/gui/),
a completely free virus checker on the internet. Heuristic scanners often flag
"hacker tool"-looking output, so read the code as well.

Known, deliberate behaviour of the non-Roblox tools:

| Tool | What it really does |
| --- | --- |
| `Mains/Python/NYHCKAssets/Main/NH.py` | Windows only. Asks for UAC elevation, prints simulated output, and can download its own update into `C:\Program Files\_nhprogfiles`. |
| `Mains/Python/NYHCKAssets/Main/DummedDown/NH.py` | Same, trimmed for Linux / iSH. Skips elevation outside Windows. |
| `Mains/Python/KSPOR.py` / `KSPORe.py` | Prints simulated "routing" / payload output. No networking. |
| `Mains/Powershell/CMF+0.2.6.ps1` | Prints simulated cookie-scan output. No persistence, no file access. |
| `Mains/Powershell/CMFEXTENSION+0.2.6.ps1` | Lists file names/sizes under your user profile and prints them. Read-only: nothing is changed. |
| `Mains/Python/CMFExtensionPython0.0.1.py` | Walks your home folder and prints file names/sizes with random "safety" verdicts. |
