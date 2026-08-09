import random
import os

output_dir = r"C:\Users\Purps\Documents\PythonScriptOutput"
os.makedirs(output_dir, exist_ok=True)

output_file = os.path.join(output_dir, "player_spawns.txt")

with open(output_file, "w") as f:
    for i in range(1,101):
        f.write(f"/player {random.choice(['Alpha', 'Bravo', 'Echo', 'Delta', 'Echo', 'Foxtrot', 'Golf', 'Hotel', 'India', 'Juliet'])}{random.randint(1, 9999)} spawn\n")

print(f"File saved to: {output_file}")