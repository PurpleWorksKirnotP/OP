import time
import random
from datetime import datetime

tn = "---[KSP/OR]:"

routing_table = {}

# to note: This tool is mostly used as a party trick LOL


def route(num):
    if num in routing_table:
        print(f"{tn} Target {num} is already routed. Re-routing & updating entry...")

    print(f"Routing operations to {num}...")
    print("Routed!")
    for i in range(1, 1001):
        src = (f"{random.randint(10, 999)}.{random.randint(10, 999)}."
               f"{random.randint(10, 999)}.{random.randint(10, 999)}")
        print(f"{tn} ROUTING OPERATIONS FROM {src} TO {num}")
        time.sleep(0.01)

    routing_table[num] = {
        "id": random.randint(100000, 999999),
        "timestamp": datetime.now().strftime("%H:%M:%S"),
        "ops": 1000,
    }
    print(f"{tn} Successfully routed all operations to {num}! "
          f"Type -k {num} to kill processes, or -l to list routes.")
    time.sleep(1)


def list_routes():
    if not routing_table:
        print(f"{tn} No active routes. Use -r <target> to route one.")
        return

    print(f"\n{tn} === ACTIVE ROUTES ===")
    print(f"{'TARGET':<20} {'ID':<10} {'OPS':<8} {'TIME':<10}")
    print("-" * 50)
    for target, info in routing_table.items():
        print(f"{target:<20} {info['id']:<10} {info['ops']:<8} {info['timestamp']:<10}")
    print("-" * 50)
    print(f"{tn} Total active routes: {len(routing_table)}\n")


def killprocess(num):
    if num not in routing_table:
        print(f"{tn} ERROR: Target '{num}' is not in the routing table.")
        print(f"{tn} Use '-l' to view active routes, or '-r {num}' to route it first.")
        return

    info = routing_table[num]
    print(f"Killing process {num} (ID: {info['id']})...")
    for i in range(1, 1001):
        identifier = (f"{random.randint(10, 999)}.{random.randint(10, 999)}."
                      f"{random.randint(10, 999)}.{random.randint(10, 999)}")
        moved_to = (f"{random.randint(10, 999)}.{random.randint(10, 999)}."
                    f"{random.randint(10, 999)}.{random.randint(10, 999)}")
        print(f"{tn} Killed process attached to {num} | "
              f"IDENTIFIER: {identifier} | MOVED TO: {moved_to}")
        time.sleep(0.01)
    print(f"{tn} Successfully killed all processes and moved them to different IPs!")

    del routing_table[num]


def kill_all():
    if not routing_table:
        print(f"{tn} No active routes to kill. Use -r <target> first.")
        return

    targets = list(routing_table.keys())
    print(f"{tn} Terminating All Processes/Hosts.. Targets: {len(targets)}")
    for t in targets:
        killprocess(t)
    print(f"{tn} Host/Process Termination complete. All processes terminated.")


def FakeDDOS(dnsprovide, TARGETWEB):
    if dnsprovide not in routing_table:
        print(f"{tn} ERROR: Target '{dnsprovide}' has no active route.")
        print(f"{tn} Use '-r {dnsprovide}' to route it first, or '-l' to view active routes.")
        return

    info = routing_table[dnsprovide]
    print(f"{tn} ===============================")
    print(f"{tn} Starting payload to {TARGETWEB}")
    print(f"{tn} HOSTING ON: {dnsprovide}")
    print(f"{tn} ROUTE ID: {info['id']} | OPS: {info['ops']} | SINCE: {info['timestamp']}")
    time.sleep(1)
    for i in range(1, 1001):
        print(f"{tn} BLAHS IN PROGRESS. TO: {TARGETWEB} | HOSTING ON: {dnsprovide}")
        time.sleep(0.01)
    print(f"{tn} Payload sent! Pinging {TARGETWEB}")
    time.sleep(0.5)
    print(f"{tn} Cannot ping LOL! Payload Complete.")
    print(f"{tn} ================================")


def FakeInfectDevices(dnsprovide, wifiip, targetwifi):
    if dnsprovide not in routing_table:
        print(f"{tn} ERROR: Target '{dnsprovide}' has no active route.")
        print(f"{tn} Use '-r {dnsprovide}' to route it first, or '-l' to view active routes.")
        return

    info = routing_table[dnsprovide]
    print(f"{tn} ===============================")
    print(f"{tn} Accessing {wifiip} | Name: {targetwifi}")
    print(f"{tn} Starting payload to {targetwifi} ... And On Surrounding Wifis | DNS: {wifiip}")
    print(f"{tn} HOSTING ON: {dnsprovide}")
    print(f"{tn} ROUTE ID: {info['id']} | OPS: {info['ops']} | SINCE: {info['timestamp']}")
    for i in range(1, 1001):
        print(f"{tn} Attempting Infect On Device... | DEVICETYPE: {random.choice(['Laptop', 'Phone', 'Desktop', 'Misc GADGET', 'Tablet'])}")
        print(f"{tn} Status: {random.choice(['SUCCESS', 'ERR', 'UNSURE'])} | Confidence: {random.randint(60, 100)}")
        time.sleep(0.01)
    print(f"{tn} Payload Complete! All surrounding devices infected.")

def Botnetting(ipprovide, targetdevicesnum):
    if ipprovide not in routing_table:
            print(f"{tn} ERROR: Target '{ipprovide}' has no active route.")
            print(f"{tn} Use '-r {ipprovide}' to route it first, or '-l' to view active routes.")
            return
    info = routing_table[ipprovide]
    print(f"{tn} ========================")
    print(f"{tn} Searching for infected devices...")
    time.sleep(0.5)
    print(f"{tn} Devices found!")
    for i in range(1, 51):
        print(f"{tn} Infecting device {i} of {targetdevicesnum}...")
        time.sleep(0.1)

art = """
__________                           
\______   \__ _______________  ______
 |     ___/  |  \_  __ \____ \/  ___/
 |    |   |  |  /|  | \/  |_> >___ \ 
 |____|   |____/ |__|  |   __/____  >
                       |__|       \/ 
"""

helpcommands = """
==================
Operation Router | A.K.A. Kiryuw's stupid panel
==================
Commands:

  -r <target>                                route operations to <target>
  -ddos <dns> <targetweb>                    DDoS payload (hosted on <dns>, hitting <target>)
  -infect <IP_HOST> <WIFI_IP> <target_wifi>  device-infection payload (hosted on <dns>, targeting <wifi>)
  -k <target>                                kill process on <target>  (must be a routed target)
  -k all                                     kill ALL routed processes
  -l / list                                  list all currently routed targets
  help / h                                   show this menu
  exit / q                                   quit KSP/OR

Hack the world!!! - Dedsec
Dedsec Was Entertainment, We Are A Movement. - Nullsec
Drink All The Booze! Hack All The Things! - Dual Core
USE THIS TOOL WISELY XD - Purps

Remember, Be More Than The Data You Produce. Cripple The Capitalists and Take Back The World!
==================
"""

wm = f"""
{tn} Running KSP/OR | Maintained by kirturneedpurp on discord
{tn} Welcome... Kaptain!!! :3
{tn} Awaiting your command.. OwO
"""


def parse(cmd):
    parts = cmd.strip().split(maxsplit=1)
    if not parts:
        return ("", "")
    return (parts[0].lower(), parts[1] if len(parts) > 1 else "")

print(art)
print()
print(wm)



while True:
    loli = input(f"{tn} ")
    flag, arg = parse(loli)

    if flag in ("exit", "quit", "q", "e"):
        print("Exiting...")
        break
    elif flag in ("help", "h"):
        print(helpcommands)
        continue
    elif flag in ("-l", "list"):
        list_routes()
        continue
    elif flag == "-k":
        if not arg:
            print(f"{tn} Usage: -k <target>  or  -k all")
        elif arg.lower() == "all":
            kill_all()
        else:
            killprocess(arg)
    elif flag == "-r":
        if arg:
            route(arg)
        else:
            print(f"{tn} Usage: -r <target>")
    elif flag == "-ddos":
        parts = arg.split()
        if len(parts) >= 2:
            dns_provider = parts[0]
            target = parts[1]
            FakeDDOS(dns_provider, target)
        else:
            print(f"{tn} Usage: -d <dns_provider> <target_website>")
            print(f"{tn} Example: -d 1.1.1.1 example.com")
    elif flag == "-infect":
        parts = arg.split()
        if len(parts) >= 2:
            dns_provider = parts[0]
            wifiip = parts[1]
            target_wifi = parts[2]
            FakeInfectDevices(dns_provider, wifiip, target_wifi)
        else:
            print(f"{tn} Usage: -infect <IP_HOST> <WIFI_IP> <target_wifi>")
            print(f"{tn} Example: -infect 8.8.8.8 23.23.23.23 HomeNetwork")
    else:
        print(f"{tn} Unknown command. Type 'help' for options.")
