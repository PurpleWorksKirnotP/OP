echo "Installing powershell... Please hold.."
echo "This may take a while depending on your internet speed.."

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
echo "Fixing any dependency issues.."
sudo apt-get install -f

sleep 0.5

echo "Powershell installed successfully! You may now run powershell by typing 'pwsh' in your terminal."
echo "You can also visit: https://github.com/PurpleWorksKirnotP/OP/blob/main/Mains/CmdPurps.md to run any powershell script (MAY NOT WORK DUE TO LACK OF LINUX SUPPORT.)"
echo "I will be working on Linux support, on the meantime, you can use the powershell script on windows or better yet, run it using Vine."

sleep 10