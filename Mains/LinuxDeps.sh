#!/usr/bin/env bash
# Installs the prerequisites used by the PowerShell / Python tools in this repo.
# Debian-based distributions only (Debian, Ubuntu, Mint, ...).
set -u

PW_VERSION="7.6.4"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

echo "Installing purps' prerequisites... Please hold.."
echo "This may take a while depending on your internet speed.."

sleep 0.5

echo "Checking if you have sudo privileges.."

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo privileges!"
  exit 1
fi

sleep 0.5

echo "Checking if prerequisites are already installed.."

if command -v curl > /dev/null && command -v pwsh > /dev/null && command -v python3 > /dev/null && command -v pip3 > /dev/null; then
    echo "All prerequisites are already installed. Exiting."
    echo "Powershell installed successfully! You may now run powershell by typing 'pwsh' in your terminal."
    echo "You can also visit: https://github.com/PurpleWorksKirnotP/OP/blob/main/Mains/CmdPurps.md to run any powershell script (MAY NOT WORK DUE TO LACK OF LINUX SUPPORT.)"
    echo "I will be working on Linux support, on the meantime, you can use the powershell script on windows or better yet, run it using Wine."
    sleep 0.5
    echo "Other dependencies are also installed already, if you encounter any issues, report them to me or dm me on discord: kirturneedpurp"
    exit 0
else
    echo "Missing one or more prerequisites. Continuing with installation..."
fi

sleep 0.5

# PowerShell ships a different .deb per architecture.
case "$(uname -m)" in
    x86_64)  DEB_ARCH="amd64" ;;
    aarch64 | arm64) DEB_ARCH="arm64" ;;
    *)
        echo "Unsupported architecture: $(uname -m). Install PowerShell manually:"
        echo "  https://github.com/PowerShell/PowerShell/releases/tag/v${PW_VERSION}"
        exit 1
        ;;
esac

DEB_FILE="powershell_${PW_VERSION}-1.deb_${DEB_ARCH}.deb"
DEB_URL="https://github.com/PowerShell/PowerShell/releases/download/v${PW_VERSION}/${DEB_FILE}"

echo "Installing wget..."

sudo apt update
sudo apt install -y wget

echo "Fetching powershell package from powershell github releases page.."
echo "  $DEB_URL"
wget -O "${WORK_DIR}/${DEB_FILE}" "$DEB_URL"

echo "Installing powershell package.."
sudo dpkg -i "${WORK_DIR}/${DEB_FILE}"
sudo apt-get install -f -y

echo "Installing curl.."
sudo apt install -y curl

echo "Installing Python..."
sudo apt install -y python3 python3-pip python3-venv

sleep 0.5

echo "Powershell installed successfully! You may now run powershell by typing 'pwsh' in your terminal."
echo "You can also visit: https://github.com/PurpleWorksKirnotP/OP/blob/main/Mains/CmdPurps.md to run any powershell script (MAY NOT WORK DUE TO LACK OF LINUX SUPPORT.)"
echo "I will be working on Linux support, on the meantime, you can use the powershell script on windows or better yet, run it using Wine."

echo "Other dependencies are also installed already, if you encounter any issues, report them to me or dm me on discord: kirturneedpurp"
