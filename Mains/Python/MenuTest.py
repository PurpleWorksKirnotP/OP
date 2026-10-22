import time

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
    # Old joke option. It used to call os.remove() on C:\Windows and friends,
    # which was never going to work outside an elevated shell - and would have
    # been catastrophic if it had. Kept as an easter egg, no file is touched.
    print("Nope. Not deleting Windows today. (No files were touched.)")
else:
    print("I said pick a number you bum")
time.sleep(2)