```
   ________  ________  ________      ________  ________  ________  ____ ___ 
  ╱    ╱   ╲╱    ╱   ╲╱        ╲    ╱    ╱   ╲╱        ╲╱        ╲╱    ╱   ╲
 ╱         ╱         ╱         ╱   ╱         ╱         ╱         ╱         ╱
╱         ╱╲__      ╱         ╱   ╱         ╱         ╱       --╱        _╱ 
╲__╱_____╱   ╲_____╱╲___╱____╱    ╲___╱____╱╲___╱____╱╲________╱╲____╱___╱ 
```

# Introducing Nya Hack V 0.1.5 BETA

It's just some shitty larper tool.

**Every command is a simulation.** Nothing is attacked, scanned, infected or
deleted - NyaHax prints generated text so it looks like a hacker panel. That is
the whole feature.

## Which file do I run?

| Your system | File |
| --- | --- |
| Windows | [`Main/NH.py`](Main/NH.py) - the full version. It asks for UAC elevation on start and refuses to run anywhere else. |
| Linux, macOS, iSH (iPhone/iPad) | [`Main/DummedDown/NH.py`](Main/DummedDown/NH.py) - the trimmed version. It skips the Windows elevation step. |

Windows:

```
python -c "import urllib.request; exec(urllib.request.urlopen('https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Python/NYHCKAssets/Main/NH.py').read().decode('utf-8'))"
```

Linux / macOS / iSH (dummed down):

```
python3 -c "import urllib.request; exec(urllib.request.urlopen('https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Python/NYHCKAssets/Main/DummedDown/NH.py').read().decode('utf-8'))"
```

REQUIREMENTS: Requests

Quick 1 line install for both systems (MUST NEED PYTHON INSTALLED)

```
pip install requests
```

Software is easy to understand.

## Guide (+ Install guide for IOS):

Installing iSH Shell on your iphone/tablet

Step 1: Go to appstore
Step 2: search up iSH Shell and download it.
Step 3: Open iSh Download these packages:

```
apk add python3
apk add py3-pip
```

Step 4: Go back to this github page and copy dummed down ver. launch command
Step 5: Proceed to running script section

Running Script

Step 1: do `-lc` to "host payloads on localhost"
Step 2: do `-sij <fakeIP> enable` to "soft inject" that IP (or `-ipinj <fakeIP>` for the brute-force flavour)
Step 2.1: do `-lc` again and stop localhosting
Step 3: Do anything under Payload Management, Infection (use `-h` to find the commands listed under em)

More commands will be added soon, I'm just too darn lazy.
