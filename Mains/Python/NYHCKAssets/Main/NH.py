encoding="utf-8"

import requests

try:
    version = requests.get("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Python/NYHCKAssets/NYHCKV.txt").text
except Exception as e:
    version = f"OFFLINE..."
    print(f"Offline mode, using fallback: {e}")

import time
import random

tn = "---[NyaHax]:"

print(f"Made this in a fucking hospital. So go crazy motha fuckas!")
print(f"Made and maintained by purpleworkskirnotp on github... | V {version}")
print(f"")

h = """
   ________  ________  ________      ________  ________  ________  ____ ___ 
  ╱    ╱   ╲╱    ╱   ╲╱        ╲    ╱    ╱   ╲╱        ╲╱        ╲╱    ╱   ╲
 ╱         ╱         ╱         ╱   ╱         ╱         ╱         ╱         ╱
╱         ╱╲__      ╱         ╱   ╱         ╱         ╱       --╱        _╱ 
╲__╱_____╱   ╲_____╱╲___╱____╱    ╲___╱____╱╲___╱____╱╲________╱╲____╱___╱  
Go crrrrazy~! Nya~!

============================================================================

= Common -

- h = prints this message 
- exit, e, -e = Exits NH

= Payload hosting - 

- lc, localhost = Hosts payload injectors on pc
- IPInj, IPInject <IP> = Force hosts payloads on different IPs
- SoftInj, sij <IP> <Disable/Enable>

= Payload Management - Manages Payload hosting.

- Stop <IP> = Terminates all processes being run on IP and deletes NyaHOS on IP.
- l, list = lists all infected IPs (Including soft injected)

= General Hacking - Self-Explanitory.

- bn <ProgramToInject> <True/False> - Infects devices to botnet.
- pswdCrack <username> <site> - Cracks passwords.. 70/30 success rate.
- DDOS, SOL, NHZD <IP> - Overwhelms servers/ips using infected devices
- dh, dhijack, devicehijack <deviceID> <IP> - Hijacks specific devices and forces them to mine bitcoin (REQUIRES SIJ, MALBUILD)
- malbuild, mb, malwarebuild <program>- Builds malware to infect devices and force them to mine bitcoin (REQUIRES SIJ)

= Debloat - Debloats your operating system.

- DbIOS - only meant for IOS devices running on Ish Shell
- DbWin - only meant for WINDOWS devices.
- dbALL, dbgen, gendebloat, generaldebloat, -allosdebloat - A General Debloat for all devices. Regardless of hardware.

= Panic -

- panic, p - Disconnects everything and exits. 

"""

def add_entry(table, ip):
    table[ip] = True

# Vars for functions

localhosting = False
bnetted = False
bndn = 0
Sij = False
malb = False
onIos = False
Randbios = False
onWindows = False
RandbWin = False

fileextensions = {
    ".exe",
    ".dll",
    ".scr",
    ".vbs",
    ".js",
    ".bat",
    ".cmd",
    ".docm",
    ".xlsm",
    ".ps1",
    ".jar",
    ".msi",
    ".com",
    ".pegasusmal",
}

filenames = {
    "invoice",
    "update",
    "svchost",
    "winlogon",
    "driver",
    "config",
    "readme",
    "setup",
    "install",
    "patch",
    "license",
    "manual",
    "support",
    "admin",
    "system",
    "security",
    "network",
    "backup",
    "database",
    "log"
}

ips = {}

# Actual Funcs Below

def DbIOS():
    global onIos
    global Randbios
    print(f"{tn} Soft Jb running... Pulled from: https://github.com/rooootdev/lara")
    time.sleep(1)
    for i in range(1, random.randint(10, 999)):
        print(f"{tn} PULLED ASSET NO. {i} FROM GITHUB REPO...")
        for i in range(1,6):
            print(f"{tn} Decompiling... [{i}/6]")
            time.sleep(0.001)
        time.sleep(0.0001)
    time.sleep(1)
    print(f"{tn} Success!")
    for i in range(1, random.randint(100, 150)):
        print(f"{tn} Scanning main IOS folder for any bloat...")
        for i in range(1, random.randint(10,20)):
            print(f"{tn} DELETING FILES [{i}/?]")
            time.sleep(0.001)
        print(f"{tn} Searching cache for unnessesary files...")
        for i in range(1, random.randint(10,20)):
            print(f"{tn} SCAN RETURNED: FOUND 1 FILE(S) OUT OF ?")
            time.sleep(0.01)
            print(f"{tn} DELETING...")
            print(f"{tn} AM > DEL FILE {random.randint(1000,9999)}")
            time.sleep(0.001)
            print(f"{tn} AMR > RETURNED RESULT: DELETED")                    
        time.sleep(0.0001)
    print(f"{tn} DEBLOAT SUCCESSFUL. Deleting Lara...")
    for i in range(1, random.randint(100,999)):
        print(f"{tn} DELETED ASSET [{i}/?] | FILEID: {random.randint(1000,9999)}")
        time.sleep(0.001)
    time.sleep(1)
    print(f"{tn} Finished!")
    print(f"---[DETAILEDREV]: Returned results: {random.randint(1000,9999)} files removed... | {random.randint(500,1000)} MB removed. | Estimated Ram usage: {random.randint(1,2)} GB usage. | Successfully Optimized.")
    onIos = True
    Randbios = True

def dbwin():
    global RandbWin
    global onWindows
    print(f"{tn} Pulling from: https://github.com/sycnex/windows10debloater...")
    winset = {
        "System",
        "Home",
        "Bluetooth & Devices",
        "Network & internet",
        "Apps",
        "Time & Language",
        "Gaming",
        "Accessibility",
        "Privacy & security"
    }
    for i in range(1,999):
        print(f"{tn} REMOVING FILE... | FILEID: {random.randint(1,9999)}")
        time.sleep(0.001)
    for i in range(1, random.randint(100,999)):
        print(f"{tn} Configuring Windows Settings Via Terminal... | [{i}/?]")
        for i in range(1,10):
            print(f"{tn} In {random.choice(winset)}...")
            print(f"{tn} Changed setting {random.randint(1,99)} | Pulled from optimization table...")
            print(f"{tn} AM > sysCh(Fromdbwin:CS):[]")
            print(f"{tn} AMR > Result: CHANGED:SUCCESS")
        time.sleep(0.001)
    time.sleep(1)
    print(f"{tn} Successfully (half) debloated windows.")
    RandbWin = True
    onWindows = True

def dbALL():
    print(f"{tn} Pulling from optimization table...")
    for i in range(1, random.randint(1000,9999)):
        print(f"{tn} AM > NH.py:(SysRun('Mod {random.randint(1,9999)}'))")
        for i in range(10,51):
            print(f"{tn} CHANGED {random.randint(1,9999)} ON CURRENT OS")
            print(f"{tn} CHANGED {random.randint(1,9999)} ON CURRENT OS")
            print(f"{tn} CHANGED {random.randint(1,9999)} ON CURRENT OS")
            print(f"{tn} CHANGED {random.randint(1,9999)} ON CURRENT OS")
            print(f"{tn} CHANGED {random.randint(1,9999)} ON CURRENT OS")
            print()
            print(f"{tn} BIOS SET: X{random.randint(1,9999)} TO AA{random.randint(1,9999)}")
    time.sleep(1)
    print(f"{tn} Successfully debloated!")

def malbuild(progn):
    global malb
    global Sij
    if Sij == True:
        malb = True
        print(f"{tn} STARTING MALBUILD...")
        print(f"{tn} PROGRAM: {progn}")
        time.sleep(1)
        print(f"{tn} Compiling spyware and mining files into {progn}...")
        for i in range(1, random.randint(100, 1001)):
            print(f"{tn} Adding {random.choice(filenames)}{random.randint(1000, 99999)}{random.choice(fileextensions)} to {progn} payload...")
            time.sleep(0.001)
        time.sleep(1)
        print(f"{tn} Successfully added files to {progn} payload. | Total Size: {random.randint(50, 500)} MB")
        print()
        print(f"{tn} Adding {progn} to Device Hijack Payloads...")
        time.sleep(1)
        print(f"{tn} Successfully added {progn} to Device Hijack Payloads.")
        print(f"{tn} Do -dh <deviceID> <IP> to hijack devices with {progn} payload.")
    else:
        print(f"{tn} This command requires -sij to be enabled first.")

def dh(deviceip, ip):
    print(f"{tn} initiating attack on {ip}")
    for i in range(1, random.randint(100, 1001)):
        print(f"{tn} Attempting OS Flash on IP/Server: {ip} | Attempt: {i}")
        time.sleep(0.01)
    time.sleep(1)
    print(f"{tn} Successfully flashed OS onto {ip} | Hijacking device {deviceip} with infected files...")
    for i in range(1, random.randint(100, 1001)):
        print(f"{tn} FILES TRANSFERED: {i} | DEVICEID: {deviceip} | IP: {ip} | SIZE: {random.randint(10, 500)} MB")
        time.sleep(0.001)
    time.sleep(1)
    print(f"{tn} successfully transfered files to {deviceip}! Enabling mining on device...")
    uinp = input(f"{tn} Enable descrete mining on device? [Y/N]: ").strip().lower()
    if uinp in ("y", "yes"):
        print(f"{tn} Enabling descrete mining on device {deviceip}...")
        for i in range(1, random.randint(100, 1001)):
            print(f"{tn} CONVERTED COMPRESSED FILE TO MINING FILE... | DEVICEID: {deviceip} | IP: {ip} | SIZE: {random.randint(50, 150)} MB")
            time.sleep(0.001)
        time.sleep(1)
        print(f"{tn} Successfully enabled mining on device {deviceip} | IP: {ip} | Mining Rate: {random.randint(50, 100)} MH/s")
    else:
        print(f"{tn} Enabling blatant mining on device {deviceip}...")
        for i in range(1, random.randint(100, 1001)):
            print(f"{tn} CONVERTED COMPRESSED FILE TO MINING FILE... | DEVICEID: {deviceip} | IP: {ip} | SIZE: {random.randint(100, 1500)} MB")
            time.sleep(0.001)
        time.sleep(1)
        print(f"{tn} Successfully enabled mining on device {deviceip} | IP: {ip} | Mining Rate: {random.randint(200, 500)} MH/s")
    print(f"{tn} Hijack finished. Device {deviceip} is now mining bitcoin for you.")
    print(f"{tn} Awaiting new command...")

def pswdc(user, site):
    print(f"{tn} Starting Password Crack Process...")
    print(f"{tn} User: {user}")
    print(f"{tn} Site: {site}")
    print(f"==========================================")
    print(f"{tn} Starting method 1: SQL Injection")
    time.sleep(1)
    lotto = random.randint(1,2)
    filn = {
        "passwords",
        "supportteampasswords",
        "adminpasswords",
        "ownpasswords",
        "secret",
        "sitekeys",
        "environtest",
        "ITtechdeppsd"
    }
    fileex = {
        ".kdb",
        ".kbdx",
        ".lpux",
        ".agilekeychain",
        ".dash",
        ".ppk",
        ".pem",
        ".cer",
        ".der",
        ".pfx",
        ".p12",
        ".pub",
        ".env",
        ".conf",
        ".config",
        ".json",
        ".yaml",
        ".yml",
        ".xml",
        ".plist",
        ".txt",
        ".csv",
        ".xls",
        ".xlsx",
        ".bak",
        ".old",
        ".tmp"
    }
    if lotto == 1:
        print(f"{tn} Success! found default STEA password!")
        time.sleep(1)
        print(f"{tn} password: SUPPORT{site}U{user}N{random.randint(1000,9999)}")
    else:
        print(f"{tn} Searching local storage...")
        time.sleep(0.2)
        for i in range(10, random.randint(100,999)):
            print(f"{tn} SEARCHED LOCAL STORAGE: FOUND: {random.choice(filn)}{random.choice(fileex)} CHECKING SERVER IF IT EXISTS")
            for i in range(5, 10):
                print(f"{tn} AM > REQUEST:FLFOUND(FILEN:FILEX).CHECK()")
                time.sleep(0.2)
                print(f"{tn} FOUND AT SERVER {i}, SITE {site}")
            time.sleep(0.01)
        print(f"{tn} success! found IT Support Easy Access Password: SUPPORT{site}U{user}N{random.randint(1000,9999)}")
    print(f"{tn} Cracking finished. Try password at your own risk...")
    print(f"{tn} IT Support Desk Employees can detect who logins at accounts, be careful.")

def SOL(ip, host):
    global Sij
    global bndn
    global bnetted
    if Sij == True and bnetted == True:
        print(f"{tn} PRE SOL:")
        print(f"- Hosting on {host}")
        print(f"- Payload Reciever: {ip}")
        time.sleep(1)
        print("")
        print(f"{tn} starting with {bndn} devices...")
        for i in range(1,1001):
            print(f"{tn} {bndn} Requests made to {ip}! | Response: {random.choice(["Good", "Med", "BAD"])} | Connection: {random.choice(["Good", "Med", "BAD"])}")
            time.sleep(0.01)
        print(f"{tn} {bndn} Requests made to {ip} | Response: SERVERFROZEN | Connection: CANNOTCONNECT2SERVER")
        time.sleep(1)
        print(f"{tn} Successfully overwhelmed server! Awaiting new payload to host on {host}")
        
def panic():
    print(f"{tn} Disconnecting all operations running from {ips}...")
    time.sleep(1)
    if localhosting == True:
        print(f"{tn} Disconnecting lc")
        for i in range(1,101):
            print(f"{tn} TERMINATED OPERATION NO {random.randint(1,999)} UNDER CODE: PAN1C")
    time.sleep(1)
    if Sij == True:
        print(f"{tn} Releasing soft injected ips and infected devices...")
        for i in range(1,101):
            print(f"{tn} DELETED INFCTPRG FROM DEVICE ID: {random.randint(1000,9999)}")
    time.sleep(0.1)
    print(f"{tn} RELEASING IPS (IF ANY)")
    time.sleep(1)
    print(f"{tn} DELETING ALL SAVED DATA... [IF ANY]")
    time.sleep(1)
    print(f"{tn} READY TO CLOSE...")
    print(f"{tn} AM > e")
    time.sleep(1)

def disablesipi(ip):
    print(f"{tn} Disabling...")
    time.sleep(0.5)
    stop(ip)
    print(f"{tn} disabled! run -sij {ip} to enable again...")

def softipinj(ip):
    global Sij
    print(f"{tn} Soft inject on {ip}...")
    for i in range(1,201):
        print(f"{tn} pinging {ip}... | Attempt {i}")
        time.sleep(0.1)
    time.sleep(1)
    print(f"{tn} Stable connection... Making {ip} as a payload hoster...")
    for i in range(1, 201):
        print(f"{tn} MADE REQUEST (POST): [Context: HOSTF(Type:FILE)] Set priority: [HIGH;=200MBPS] | REQUEST {i} OUT OF 200")
        print(f"{tn} MESSAGE RECIEVED FROM SERVER/IP, REQUEST: [Context: ACCEPTED] | MBPS ALLOCATED...")
        time.sleep(0.01)
    print(f"{tn} All requests sent! Testing if inject successful...")
    print(f"{tn} AM > ptstpl {ip} true 200")
    for i in range(1,101):
        print(f"{tn} Payload test | FILES: {i}/100 | Uid: {random.randint(1000,9999)}")
        time.sleep(0.01)
    time.sleep(0.5)
    print(f"{tn} test success | Details: IP transfered {random.randint(10,6114)} mb of data over 100 requests all returning with a success.")
    time.sleep(0.1)
    print(f"{tn} Cleaning up files...")
    for i in range (1,101):
        print(f"{tn} DELETING TEST FILE {i} | size {random.randint(10,500)} mb")
    time.sleep(0.01)
    print(f"{tn} Cleaned out all test files... Awaiting command on host {ip}...")
    add_entry(ips, ip)
    Sij = True

def stop(ip):
    print(f"{tn} Stopping {ip}...")
    ips[ip] = False

def fbotnet(Fprog, bau):
    global bndn
    global bnetted
    pipelines = {
        "s:releases",
        "bu:releases",
        "gm:releases"
    }

    print(f"{tn} pipelines: {pipelines}")

    imp = input(f"{tn} type out a release pipeline: ")

    for p in pipelines:
        if p.lower() in imp:
            print(f"{tn} proceeding...")
            break
        else:
            print(f"{tn} failed, exitting to prevent crash")
            break

    print(f"{tn} Preparing payload with {Fprog}... Delivering via {imp}")
    print(f"{tn} BAU: {bau}")
    time.sleep(1)
    for i in range(1, 501):
        print(f"{tn} Forcing payload on vulnerable devices... | DEVICEID: {random.randint(1000,9999)} | FOUND ON: {random.randint(0,255)}.{random.randint(0,255)}.{random.randint(0,255)}.{random.randint(0,255)}")
        time.sleep(0.01)
    time.sleep(2)
    rndnb = random.randint(1,500)
    print(f"{tn} successfully infected {rndnb} devices out of 500!")
    bndn = rndnb
    bnetted = True

def listinfects():
    global ips
    print(f"================================")
    print(f"{tn} All Infected Ips")
    for ip, value in ips.items():
        print(f"{tn} infected IP: {ip} | Enabled: {value}")
    print(f"=================================")

def IPInj(Fip):
    global localhosting
    if localhosting == True:
        print(f"{tn} Initializing attack on {Fip}")
        time.sleep(1)
        for i in range(1, 501):
            print(f"{tn} BRUTE FORCING PASSWORD | Attempt: {i}")
            time.sleep(0.001)
        print(f"{tn} Flashing OS onto IP/Router")
        time.sleep(2)
        print(f"{tn} Generated NyaHOS... Attempting to flash on IP/Router")
        for i in range(1, 30):
            print(f"{tn} Transfered {i} mb of data...")
            time.sleep(2)
        print(f"{tn} Successfully transfered! Starting up NyaHOS on IP router. This may take some time.")
        time.sleep(2)
        print(f"{tn} success! Flashing payload host OS on router/IP...")
        time.sleep(1)
        for i in range(1, 501):
            print(f"{tn} FROM HOST PC GENERATED FILE: {random.choice(["Stealer", "Injecter", "Spyware", "Wormware", "RAT"])}{random.randint(1000,9999)}.{random.choice(["exe", "dat", "json","txt", "tar.gz", "snap", "NYAHC", "sqlite"])} TO {Fip}")
            time.sleep(0.01)
        add_entry(ips, Fip)
        print(ips)
        print(f"{tn} success! IP/Router infected.")
    else:
        print(f"[ERROR]: do -lc first dumbass")

def lc():
    global localhosting

    if localhosting == False:
        print(f"{tn} Routing Operations To Localhost, Nya!")
        for i in range(1, 1001):
            print(f"{tn} OPERATION ROUTED FROM {random.randint(0,255)}.{random.randint(0,255)}.{random.randint(0,255)}.{random.randint(0,255)} TO LOCALHOST")
            time.sleep(0.01)
        print(f"{tn} Ready To Host Payload. Recommended =  IPInj")
        localhosting = True
    else:
        print(f"{tn} Do you want to end localhost?")
        yn = input("[Y/N?]:").strip().lower()
        if yn in ("y", "yes"):
            print(f"{tn} killing all processes attached to localhost...")
            time.sleep(1)
            print(f"{tn} done!")
            localhosting = False
        else:
            print(f"{tn} Exitting")

print(h)

testa = 12
testb = 13

inta = input("enter your operating system. [ios/windows/linux]: ").lower()

if inta == "ios":
    print(f"Running NyaHax {version} on IOS/Mac")
    onIos = True
elif inta == "windows":
    print(f"Running NyaHax {version} on Windows.")
    onWindows = True
else:
    print(f"Running Nyahax {version} on Linux.")

while True:
    uwu = input(f"{tn} ")

    bd = uwu.split()

    flag = bd[0].lower()

    context = bd[1].lower() if len(bd) > 1 else None
    context2 = bd[2].lower() if len(bd) > 2 else None
    context3 = bd[3].lower() if len(bd) > 3 else None

    if flag == "-h":
        print(h)
    elif flag in ["exit", "e", "-e"]:
        break
    elif flag in ["-lc", "localhost"]:
        lc()
    elif flag in ["-ippinj", "-ipinj", "-ipinj", "-ipj", "ipinject"]:
        IPInj(context)
    elif flag in ["-l", "-list"]:
        listinfects()
    elif flag in ["-bn", "-bnt", "botnet"]:
        if bnetted == True:
            print("You cannot bn again. Would you like to brick/uninfect devices?")
            ui = input("[y/n]: ").lower()
            if ui in ["y", "n"]:
                fbotnet(context, context2)
            else:
                print(f"{tn} exitted")
        else:
            fbotnet(context, context2)
    elif flag in ["stop", "-s"]:
        stop(context)
    elif flag in ["-softinj", "-sij", "softinject"]:
        if context2 == "disable":
            disablesipi(context)
        elif context2 == "enable":
            softipinj(context)
        else:
            print(f"{tn}: Disable/Enable not found in context2... Exiting...")
    elif flag in ["-p", "-panic", "p", "panic"]:
        panic()
        break
    elif flag in ["-ddos", "-sol", "-nhzd"]:
        SOL(context, context2)
    elif flag in ["-pswdcrack", "-pswdc"]:
        pswdc(context, context2)
    elif flag in ["-dh", "-dhijack", "-devicehijack"]:
        if malb == True and Sij == True:
            dh(context, context2)
        else:
            print(f"{tn} This command requires -sij and -malbuild to be enabled first.")
    elif flag in ["-malbuild", "-mb", "-malwarebuild"]:
        if malb == True:
            print(f"{tn} You cannot malbuild again. Would you like to disable soft inject and re-enable it?")
            ui = input("[y/n]: ").lower()
            if ui in ["y", "yes"]:
                malbuild(context)
            else:
                print(f"{tn} exitted")
        else:
            malbuild(context)
    elif flag in ["-dbios", "debloatios", "-debloatios"]:
        if onIos == True:
            DbIOS()
        else:
            print(f"{tn} You're on windows. do -dbwin instead OR -dball for a general debloat if on Linux.")
    elif flag in ["-dbwin", "-dbwindows", "debloatwindows"]:
        if onWindows == True:
            dbwin()
        else:
            print(f"You're on IOS. do -dbios instead OR -dball for a general debloat if on linux.")
    elif flag in ["-dball", "-dbgen", "gendebloat", "generaldebloat", "-allosdebloat"]:
        dbALL()
    else:
        print(f"{tn} command not found... Try typing -h")