```text
   ________  ________  ________      ________  ________  ________  ____ ___
  ╱    ╱   ╲╱    ╱   ╲╱        ╲    ╱    ╱   ╲╱        ╲╱        ╲╱    ╱   ╲
 ╱         ╱         ╱         ╱   ╱         ╱         ╱         ╱         ╱
╱         ╱╲__      ╱         ╱   ╱         ╱         ╱       --╱        _╱
╲__╱_____╱   ╲_____╱╲___╱____╱    ╲___╱____╱╲___╱____╱╲________╱╲____╱___╱
```

# NyaHax v0.1.5 BETA

It's just some shitty larper tool.

> **Every command is a simulation.** Nothing is attacked, scanned, infected or
> deleted — NyaHax prints generated text so it looks like a hacker panel. That is the
> whole feature.

---

## Which file do I run?

| Your system | File |
| --- | --- |
| Windows | [`Main/NH.py`](Main/NH.py) — the full version. It asks for UAC elevation on start and refuses to run anywhere else. |
| Linux, macOS, iSH (iPhone/iPad) | [`Main/DummedDown/NH.py`](Main/DummedDown/NH.py) — the trimmed version. It skips the Windows elevation step. |

**Windows**

```powershell
python -c "import urllib.request; exec(urllib.request.urlopen('https://raw.githubusercontent.com/PurpleWorksKirnotP/PurpleScripts/refs/heads/main/Mains/Python/NYHCKAssets/Main/NH.py').read().decode('utf-8'))"
```

**Linux / macOS / iSH (dummed down)**

```bash
python3 -c "import urllib.request; exec(urllib.request.urlopen('https://raw.githubusercontent.com/PurpleWorksKirnotP/PurpleScripts/refs/heads/main/Mains/Python/NYHCKAssets/Main/DummedDown/NH.py').read().decode('utf-8'))"
```

### Requirements

- **Requests** — one dependency, on both systems
- **Python** must already be installed

One-line install:

```bash
pip install requests
```

Software is easy to understand.

---

## Install guide for iOS (iSH)

1. Go to the App Store.
2. Search for **iSH Shell** and download it.
3. Open iSH and download these packages:

   ```bash
   apk add python3
   apk add py3-pip
   ```

4. Come back to this GitHub page and copy the **dummed down** launch command.
5. Continue to the running section below.

---

## Running the script

1. Run `-lc` to "host payloads on localhost".
2. Run `-sij <fakeIP> enable` to "soft inject" that IP — or `-ipinj <fakeIP>` for the
   brute-force flavour.
   1. Run `-lc` again and stop localhosting.
3. Do anything under **Payload Management** or **Infection** — use `-h` to see the
   commands listed under them.

More commands will be added soon, I'm just too darn lazy.

---

[Back to the cmd guides](../../CmdPurps.md) | [Back to the main README](../../../README.md)
