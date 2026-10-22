# NEW: Larp Larp Tool

Jump to [LarpLarp Page](Python/NYHCKAssets/NHIntroduction.md)

# How to use CMF (Power shell)

> **Everything CMF prints is a simulation.** It does not read browser cookies, it
> does not upload anything, and it does not install itself at login. The Wi-Fi /
> shutdown behaviour that older versions of `CMFEXTENSION` had has been removed.

## Prerequisites:

Windows Power shell

Windows or any Debian based linux distribution (e.g. Linux Mint: Cinnamon, Ubuntu, Debian)

To download Windows power shell on Debian based Linux distros:

Installs power shell and any dependencies (run as root)

First:
```
sudo su
```

Second:
```
curl -fsSL https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/LinuxDeps.sh | bash 
```

---

Run this command in power shell
```
irm https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Powershell/CMF%2B0.2.6.ps1 | iex
```

## CMFEXTENSION:

```
irm https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Powershell/CMFEXTENSION%2B0.2.6.ps1 | iex
```

and boom! You have CMF running.

Download any Power shell file (WINDOWS) and run them with power shell.

# KSP/OR (Operation Router)

A fake "operation router" panel. Every command (`-r`, `-ddos`, `-infect`, `-k`) only
prints generated text - nothing is routed, hosted or terminated. Source:
[`Python/KSPOR.py`](Python/KSPOR.py).

```
python Mains/Python/KSPOR.py
```

Install the one third-party dependency first (repo root):

```
python -m pip install -r requirements.txt
```

### Building the Windows exe

`KSPORe.exe` is **not committed** any more - build output does not belong in git.
The recipe is [`Python/KSPORe.spec`](Python/KSPORe.spec), which needs PyInstaller:

```
python -m pip install "pyinstaller>=6,<7"
cd Mains/Python
pyinstaller KSPORe.spec
```

The exe is written to `Mains/Python/dist/`, which is ignored by git. Rebuild it
rather than trusting a binary - the one that used to be in this repo was built
from an older copy of the source.

# Python CMF


## A wee bit advanced than power shell. However does allow advanced stuff.. I think?


**How to run CMF Extensions Py**

## Prerequisites:

---

- Windows Power shell
- Curl (Pre-installed with windows 10-11)
- Any recent Python 3 (the 3.12-only f-string syntax is gone; tested on 3.11)

---

Run this command in power shell (AS ADMINISTRATOR) to install prerequisites:

```
irm "https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Python/Precaution.ps1" | iex
```

## Running Python Scripts:


**C.M.F. Extensions Python 0.0.1

```
(irm "https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Python/CMFExtensionPython0.0.1.py") | python -
```

The trimmed-down variant for small Linux / iSH shells:

```
python3 -c "import urllib.request; exec(urllib.request.urlopen('https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Python/CMFExtensionPython0.0.1LINUXCUT.py').read().decode('utf-8'))"
```

## Discord webhook scripts

`Sender.py` and `Powershell/Test.ps1` no longer contain a webhook URL. Pass your own:

```
export DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/..."
python Mains/Python/Sender.py
```

---

Back to [Main](../README.md)
