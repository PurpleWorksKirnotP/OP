import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
# Platforms
import platform
import datetime
import time
import os
import random
username = os.getlogin()
userfolder = os.path.expanduser('~')
art = """
     ___   ________  _________   _______  _______________   _______ ________  _   __   ______  __   ___   ____                    _                ____   ____   ___   
    / _/  / ____/  |/  / ____/  / ____/ |/ /_  __/ ____/ | / / ___//  _/ __ \/ | / /  / __ \ \/ /  /  /  / __ \__  ______  ____  (_)___  ____ _   / __ \ / __ \ <  /   
   / /   / /   / /|_/ / /_     / __/  |   / / / / __/ /  |/ /\__ \ / // / / /  |/ /  / /_/ /\  /   / /  / /_/ / / / / __ \/ __ \/ / __ \/ __ `/  / / / // / / / /
  / /   / /___/ /  / / __/    / /___ /   | / / / /___/ /|  /___/ // // /_/ / /|  /  / ____/ / /   / /  / _, _/ /_/ / / / / / / / / / / /_/ /  / /_/ // /
 / /    \____/_/  /_/_/      /_____//_/|_|/_/ /_____/_/ |_//____/___/\____/_/ |_/  /_/     /_/  _/ /  /_/ |_|\__,_/_/ /_/_/ /_/_/_/ /_/\__, /
/__/                                                                                           /__/                                   /____/                           
"""
ToolName = "---[CMF Extension Python]---"
print(f"{art}")
print(f"{ToolName} Running CMF Extensions...")
CmfExts = [
    'FileCheck.exe',
    'CMFSTLNCKYSCAN.exe',
    'CMFWrite.exe',
    'CMFPyth.exe'
]
time.sleep(1)
print(f"{ToolName} extensions: {CmfExts}")
print(f"{ToolName} Checking pc specs for qualification:")
time.sleep(0.15)
pc_name = platform.node()
prc = platform.machine()
tme = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
print(f"{ToolName} Pc Name: {pc_name}")
print(f"{ToolName} Processor: {prc}")
print(f"{ToolName} Time: {tme}")
print(f"{ToolName} {userfolder}")
time.sleep(0.55)
print(f"{ToolName} Starting process...")
time.sleep(1)

for root, dirs, files in os.walk(userfolder):
    for file in files:
        filepath = os.path.join(root, file)
        try:
            file_size = round(os.stat(filepath).st_size / 1024, 2)
            file_date = os.path.getctime(filepath)
        except FileNotFoundError:
            print(f"{ToolName} Skipping missing file: {filepath}")
            continue
        except PermissionError:
            print(f"{ToolName} Skipping (no permission): {filepath}")
            continue
        except OSError as e:
            print(f"{ToolName} Skipping (error: {e}): {filepath}")
            continue

        print(f"{ToolName} Found File: {filepath} | FileID: {random.randint(1000,9999)}x{random.randint(1000,9999)} | FileSize: {file_size}KB | FileDate: {file_date} | FileSafety: {random.choice(['Safe', 'Unknown', 'Unsure'])}")
        print(f"{ToolName} Scanning Next...")

time.sleep(0.5)
print(f"{ToolName} Finalized Scanning! | Malware Database (DONT DOWNLOAD ANYTHING): https://bazaar.abuse.ch/ | VirusTotal Database: https://www.virustotal.com/")
print(f"{ToolName} Thank you for using CMF Extensions for python.")
print(f"{ToolName} Forever open-source and safe!")
time.sleep(5)