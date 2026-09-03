encoding="utf-8"

import requests

try:
    content = requests.get("https://raw.githubusercontent.com/PurpleWorksKirnotP/OP/refs/heads/main/Mains/Python/NYHCKAssets/NYHCKV.txt").text
except Exception as e:
    content = f"OFFLINE..."
    print(f"Offline mode, using fallback: {e}")

import time
import random

tn = "---[NyaHax]:"

print(f"Made this in a fucking hospital. So go crazy motha fuckas!")
print(f"Made and maintained by purpleworkskirnotp on github... | V {content} or 0.0.9 (HARDCODED)")
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

= Payload Management - 

- Stop <IP> = Terminates all processes being run on IP and deletes NyaHOS on IP.
- l, list = lists all infected IPs (Including soft injected)

= Infection -

- bn <ProgramToInject> <True/False> - Infects devices to botnet
- pswdCrack <username> <site> - Cracks passwords.. 70/30 success rate.
- DDOS, SOL, NHZD <IP> - Overwhelms servers/ips using infected devices

= Panic -

- panic, p - Disconnects everything and exits. 

"""

def add_entry(table, ip):
    table[ip] = True

localhosting = False
bnetted = False
bndn = 0
Sij = False

ips = {}

# Below this are the actual funcs

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
            print(f"{tn} {bndn} Requests made to {ip}! | Response: BAD | Connection: BAD")
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
            print(f"{tn} FROM HOST PC GENERATED FILE: NYHCKDEPFILE{random.randint(1000,9999)}.exe TO {Fip}")
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
        for i in range(1, random.randint(1001, 9999)):
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

# DONT TOUCH TESTA TESTB

testa = 12
testb = 13

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
    elif flag in ["-pswdcrack","-pcrack","-pc","passwordcrack"]:
        if localhosting == True:
            pswdc(context, context2)
        else:
            print(f"{tn} This command requires -lc")
    else:
        print(f"{tn} command not found... Try typing -h")