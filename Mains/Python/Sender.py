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
    # Get webhook URL (from env var or prompt) - never hard-code it in the repo
    webhook_url = os.environ.get("DISCORD_WEBHOOK_URL", "").strip()

    if not webhook_url:
        webhook_url = input("Discord webhook URL: ").strip()

    if not webhook_url.startswith("https://discord.com/api/webhooks/"):
        print("That does not look like a Discord webhook URL. Exiting.")
        sys.exit(1)

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
    send_to_discord(webhook_url, message)


if __name__ == "__main__":
    main()