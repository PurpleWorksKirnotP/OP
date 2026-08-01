echo "Installing purps' prerequisites... Please hold.."
echo "This may take a while depending on your internet speed.."

sleep 0.5

echo "Checking if you have sudo privileges.."

if [ $EUID -ne 0 ]; then
  echo "Please run this script with sudo privileges!"
  exit 1
fi
wait

sleep 0.5

echo "Checking if prerequisites are already installed.."

if which curl > /dev/null && which pwsh > /dev/null && which python3 > /dev/null && which pip3 > /dev/null; then
    echo "All prerequisites are already installed. Exiting."
    exit 0
else
    echo "Missing one or more prerequisites. Continuing with installation..."
fi

sleep 0.5

echo "Installing wget..."

sudo apt update
sudo apt install -y wget
wait
echo "Fetching powershell package from powershell github releases page.."
wget https://github.com/PowerShell/PowerShell/releases/download/v7.6.4/powershell_7.6.4-1.deb_amd64.deb
wait
echo "Installing powershell package.."
sudo dpkg -i powershell_7.6.4-1.deb_amd64.deb
wait
sudo apt-get install -f
wait
echo "Installing curl.."
sudo apt install -y curl
wait
echo "Installing Python..."
sudo apt install -y python3 python3-pip python3-venv

sleep 0.5

echo "Powershell installed successfully! You may now run powershell by typing 'pwsh' in your terminal."
echo "You can also visit: https://github.com/PurpleWorksKirnotP/OP/blob/main/Mains/CmdPurps.md to run any powershell script (MAY NOT WORK DUE TO LACK OF LINUX SUPPORT.)"
echo "I will be working on Linux support, on the meantime, you can use the powershell script on windows or better yet, run it using Vine."

echo "Other dependencies are also installed already, if you encounter any issues, report them to me or dm me on discord: kirturneedpurp"

sleep 10