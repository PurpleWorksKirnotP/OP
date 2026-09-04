encoding="utf-8"

import time
import random

tn = "---[NyaHax]:"

print(f"Made this in a fucking hospital. So go crazy motha fuckas!")
print(f"")

h = """
   ________  ________  ________      ________  ________  ________  ____ ___ 
  ╱    ╱   ╲╱    ╱   ╲╱        ╲    ╱    ╱   ╲╱        ╲╱        ╲╱    ╱   ╲
 ╱         ╱         ╱         ╱   ╱         ╱         ╱         ╱         ╱
╱         ╱╲__      ╱         ╱   ╱         ╱         ╱       --╱        _╱ 
╲__╱_____╱   ╲_____╱╲___╱____╱    ╲___╱____╱╲___╱____╱╲________╱╲____╱___╱  

============================================================================

- h = prints this message 
- exit, e, -e = Exits NH
- lc, localhost = Hosts payload injectors on pc
- IPInj, IPInject <IP> = Force hosts payloads on different IPs
- Stop <IP> = Terminates all processes being run on IP and deletes NyaHOS on IP.
- l, list = lists all infected IPs
- Botnet <ProgramToInject> <True/False> - Infects devices to botnet

"""

def add_entry(table, ip):
    table[ip] = True

localhosting = False

ips = {}

def softipinj(ip):
    print(f"{tn} Soft inject on {ip}...")
    for i in range(1,201):
        print(f"{tn} pinging {ip}... | Attempt {i}")
        time.sleep(0.1)
    time.sleep(1)
    print(f"{tn} Stable connection... Making {ip} as a payload hoster...")
    for i in range(1, 501):
        print(f"{tn} MADE REQUEST (POST): [Context: HOSTF(Type:FILE)] Set priority: [HIGH;=200MBPS] | REQUEST {i} OUT OF 500")
        print(f"{tn} MESSAGE RECIEVED FROM SERVER/IP, REQUEST: [Context: ACCEPTED] | MBPS ALLOCATED...")

def stop(ip):
    print(f"{tn} Stopping {ip}...")
    ips[ip] = False

def fbotnet(Fprog, bau):
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
    print(f"{tn} successfully infected {random.randint(1,500)} devices out of 500!")



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

while True:
    uwu = input(f"{tn} ")

    bd = uwu.split()

    flag = bd[0].lower()

    context = bd[1] if len(bd) > 1 else None
    context2 = bd[2] if len(bd) > 2 else None
    context3 = bd[3] if len(bd) > 3 else None

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
        fbotnet(context, context2)
    elif flag in ["stop", "-s"]:
        stop(context)
    else:
        print(f"{tn} command not found... Try typing -h")