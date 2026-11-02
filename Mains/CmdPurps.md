# Purp's Command-Line Guides

Everything here is a **simulation**: the tools print generated text for fun. Nothing
is attacked, scanned, infected or uploaded.

| Guide | Jump to |
| --- | --- |
| NyaHax (Larp Larp tool) | [LarpLarp page](Python/NYHCKAssets/NHIntroduction.md) |
| CMF for PowerShell | [CMF](#cmf-powershell) |
| KSP/OR operation router | [KSP/OR](#kspor-operation-router) |
| CMF for Python | [Python CMF](#python-cmf) |
| Discord webhook scripts | [Sender](#discord-webhook-scripts) |

---

## CMF (PowerShell)

> **Everything CMF prints is a simulation.** It does not read browser cookies, it does
> not upload anything, and it does not install itself at login. The Wi-Fi / shutdown
> behaviour that older versions of `CMFEXTENSION` had has been removed.

### Prerequisites for CMF

- Windows PowerShell, on Windows **or** any Debian-based Linux distribution
  (Linux Mint: Cinnamon, Ubuntu, Debian, ...)
- To get PowerShell on Debian-based distros, install it and its dependencies first
  (run as root):

```bash
sudo su
```

```bash
curl -fsSL https://raw.githubusercontent.com/PurpleWorksKirnotP/PurpleScripts/refs/heads/main/Mains/LinuxDeps.sh | bash
```

### Running CMF

Run this in PowerShell:

```powershell
irm https://raw.githubusercontent.com/PurpleWorksKirnotP/PurpleScripts/refs/heads/main/Mains/Powershell/CMF%2B0.2.6.ps1 | iex
```

### Running CMFEXTENSION

```powershell
irm https://raw.githubusercontent.com/PurpleWorksKirnotP/PurpleScripts/refs/heads/main/Mains/Powershell/CMFEXTENSION%2B0.2.6.ps1 | iex
```

And boom — you have CMF running.

You can also download any PowerShell file from this repo (Windows only) and run it
with PowerShell yourself.

---

## KSP/OR (Operation Router)

A fake "operation router" panel. Every command (`-r`, `-ddos`, `-infect`, `-k`) only
prints generated text — nothing is routed, hosted or terminated. Source:
[`Python/KSPOR.py`](Python/KSPOR.py).

```bash
python Mains/Python/KSPOR.py
```

Install the one third-party dependency first (from the repo root):

```bash
python -m pip install -r requirements.txt
```

### Building the Windows exe

`KSPORe.exe` is **not committed** any more — build output does not belong in git. The
recipe is [`Python/KSPORe.spec`](Python/KSPORe.spec), which needs PyInstaller:

```bash
python -m pip install "pyinstaller>=6,<7"
cd Mains/Python
pyinstaller KSPORe.spec
```

The exe is written to `Mains/Python/dist/`, which is ignored by git. Rebuild it rather
than trusting a binary — the one that used to be in this repo was built from an older
copy of the source.

---

## Python CMF

A wee bit more advanced than PowerShell, but it does allow advanced stuff... I think?

### Prerequisites for Python CMF

- Windows PowerShell
- Curl (pre-installed with Windows 10–11)
- Any recent Python 3 (the 3.12-only f-string syntax is gone; tested on 3.11)

Run this in PowerShell **as administrator** to install the prerequisites:

```powershell
irm "https://raw.githubusercontent.com/PurpleWorksKirnotP/PurpleScripts/refs/heads/main/Mains/Python/Precaution.ps1" | iex
```

### Running the Python scripts

**CMF Extensions Python 0.0.1**

```powershell
(irm "https://raw.githubusercontent.com/PurpleWorksKirnotP/PurpleScripts/refs/heads/main/Mains/Python/CMFExtensionPython0.0.1.py") | python -
```

The trimmed-down variant for small Linux / iSH shells:

```bash
python3 -c "import urllib.request; exec(urllib.request.urlopen('https://raw.githubusercontent.com/PurpleWorksKirnotP/PurpleScripts/refs/heads/main/Mains/Python/CMFExtensionPython0.0.1LINUXCUT.py').read().decode('utf-8'))"
```

---

## Discord webhook scripts

`Sender.py` and `Powershell/Test.ps1` no longer contain a webhook URL. Pass your own:

```bash
export DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/..."
python Mains/Python/Sender.py
```

---

[Back to the main README](../README.md)
