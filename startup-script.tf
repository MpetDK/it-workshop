
#wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb

#sudo apt-get install --assume-yes ./chrome-remote-desktop_current_amd64.deb

#sudo apt update && sudo apt upgrade

#sudo apt install xrdp

#sudo apt install slim

#sudo apt install ubuntu-desktop

# Opret en bruger
#sudo useradd -m -s /bin/bash mahp

# Prompt for a password
#read -s -p "Enter a password for mahp: " password
#echo "mahp:wales12" | sudo chpasswd

# Tilføj brugeren til RDP-gruppen (hvis du bruger Chrome Remote Desktop)
#sudo usermod -aG chrome-remote-desktop brugernavn

# (Valgfrit) Hvis du bruger en anden RDP-løsning, såsom XRDP, tilføj brugeren til de nødvendige grupper:
#sudo usermod -aG sudo,adm brugernavn



#sudo service slim start