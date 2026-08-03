import requests
import os
import sys


def send_to_discord(webhook_url: str, message: str, username: str = None) -> bool:
    """Send a message to Discord via webhook. Returns True on success."""
    payload = {"content": message}
    if username:
        payload["username"] = username

    try:
        response = requests.post(webhook_url, json=payload, timeout=10)
        if response.status_code == 204:
            print("Message sent successfully!")
            return True
        else:
            print(f"   Failed to send: {response.status_code}")
            print(f"   Response: {response.text}")
            return False
    except requests.exceptions.RequestException as e:
        print(f"Network error: {e}")
        return False


def main():
    # Get webhook URL (from env var or prompt)
    webhook_url = os.environ.get("https://discord.com/api/webhooks/1516428299306401893/A4e1dSRCatc--8VAmh4EoYY1IfUdhkJDR5MKSskTT_xrgpdzNNGyjIg5AH7YZ_zXtl9L")

    if not webhook_url:
        print("No DISCORD_WEBHOOK_URL env var set.")
        webhook_url = input("Enter your Discord webhook URL: ").strip()

    if not webhook_url.startswith("https://discord.com/api/webhooks/"):
        print("That doesn't look like a valid Discord webhook URL.")
        sys.exit(1)

    # Optional custom username
    username = input("Custom username (press Enter to skip): ").strip() or None

    # Get the message from the user
    print()
    message = input("What message would you like to send? ")

    if not message.strip():
        print("Message cannot be empty.")
        sys.exit(1)

    if len(message) > 2000:
        print("Message exceeds Discord's 2000 character limit.")
        sys.exit(1)

    # Send it
    print("\nSending...")
    send_to_discord(webhook_url, message, username)


if __name__ == "__main__":
    main()