#!/bin/bash
#Helper script to assist in loading of github repos and setting up kits

#relevant files will be stored here
sudo ls # get sudo before we start
echo "Clearing screen before we start..."
sleep .5 && clear

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Declare variables

# Create time stamp function
get_timestamp() {
  # display date time as "01Jun2024_01:30:00-PM"
  date +"%d%b%Y_%H:%M:%S-%p"
}

project="C-Lab" # Main folder for storage of downloads
folder="$HOME/$project" # Path to project folder where downloads will go
logg="$folder/install_log" # Log used to record where programs are stored
git_folder="$folder/GitHub" # Folder used to store GitHub repos


#check to see if the "project" folder exists in home directory and, if not create one
cd ~
if [ ! -d "$folder" ]; then
  echo "$project folder not found. Creating..."
  mkdir "$folder"
  echo "$project folder created successfully. - $(get_timestamp)" | tee -a $logg
else  
  echo "$project folder already exists. - $(get_timestamp)" | tee -a $logg
fi

#change to the default folder
cd $folder

#create install_log
if [ ! -d "$folder/install_log" ]; then
    echo "install_log not found. Creating..."
    sudo touch "$folder/install_log"
    sudo chmod 777 "$folder/install_log" # install_log reffered to var name $logg
    echo "install_log created successfully. - $(get_timestamp)" | tee -a $logg
else
    echo "install_log folder already exists. - $(get_timestamp)" | tee -a $logg
fi

echo "Install log located at $folder/install_log - $(get_timestamp)" | tee -a $logg
echo "Install log created, begin tracking - $(get_timestamp)" | tee -a $logg

# Open a new terminal to monitor install_log
sudo apt install -y gnome-terminal
echo "Opening new terminal to monitor install_log..."
gnome-terminal --window --profile=AI -- bash -c "watch -n .5 tail -f $logg"
sleep 3

# Update and upgrade machine ########
###echo "Start machine update & full upgrade - $(get_timestamp)" >> $logg
#sudo apt update -y && sudo apt upgrade -y #for normal updates
#sudo apt update -y && sudo apt full-upgrade -y #everything upgrade
###echo "Finish machine update & full upgrade - $(get_timestamp)" >> $logg

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# apt installs:

cd $HOME
function install_apt_tools() {
	echo "starting install of apt tools"
 	for tool in $@; do
		if ! dpkg -l | grep -q "^ii $tool"; then
			sudo apt install -y "$tool" && echo "Installed apt $tool - $(get_timestamp)" | tee -a $logg
	else
		echo "Tool $tool is already installed. $(get_timestamp)" | tee -a $logg
	fi
    done
}

#list out tools for apt install below
install_apt_tools flameshot pwncat openssl osslsigncode mingw-w64 nodejs npm nim cmake golang httrack htop pipx

# Special install for cheat:
cd $HOME

#Check if the 'cheat' tool is installed, and install it if not
echo "Checking install status of 'cheat' tool"
if ! command -v cheat >/dev/null 2>&1; then
    echo "Installing 'cheat'"
    cd /tmp \
    && wget https://github.com/cheat/cheat/releases/download/4.4.2/cheat-linux-amd64.gz \
    && gunzip cheat-linux-amd64.gz \
    && chmod +x cheat-linux-amd64 \
    && sudo mv cheat-linux-amd64 /usr/local/bin/cheat
    echo "Installed 'cheat' - $(get_timestamp)" | tee -a $logg
    echo "Setting up cheat for the first time, standby..."
    yes | cheat scp
    echo "Set up of 'cheat' complete at: /usr/local/bin/cheat - $(get_timestamp)" | tee -a $logg
else
    echo "Tool 'cheat' is already installed. $(get_timestamp)" | tee -a $logg
fi


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Check to see if "gitlab" folder exists in project directory and if not creates one
# Create github folder for downloads:

if [ ! -d "$git_folder" ]; then
  echo "$git_folder folder not found. Creating..."
  sudo mkdir "$git_folder" && sudo chmod 777 "$git_folder"
  echo "$git_folder folder created successfully. - $(get_timestamp)" | tee -a $logg
else  
  echo "$git_folder folder already exists" | tee -a $logg
fi

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

cd $git_folder
# Download the following gitlab repos:
repo_urls=(
# List of GitLab reps urls:
# REQUIRED:
"https://github.com/yen5004/2025_cmd_logr.git"
"https://github.com/yen5004/More_dots.git"
"https://github.com/cheat/cheat.git"
"https://github.com/yen5004/cheat_helper.git"
#
# NOT REQUIRED
"https://github.com/yen5004/1-liner-ls--la-.git"
"https://github.com/yen5004/updog.git"
"https://github.com/gchq/CyberChef.git"
"https://github.com/yen5004/SCRIPTS.git"
"https://github.com/tmux-plugins/tpm.git"
"https://github.com/tmux-plugins/list.git"
"https://github.com/tmux-plugins/tmux-logging.git"
"https://github.com/yen5004/dns-exfil-infil.git"
"https://github.com/yen5004/EICAR_python.git"
"https://github.com/yen5004/dnslib.git"
"https://github.com/freeipa/freeipa.git"
)

# Directory of where repos will be cloned:

echo "       ^"  | tee -a $logg
echo "      ^^^" | tee -a $logg
echo "     ^^^^^"| tee -a $logg
echo "      ^^^" | tee -a $logg
echo "       ^"  | tee -a $logg


for repo_url in "${repo_urls[@]}"; do
  repo_name=$(basename "$repo_url" .git) # Extract repo name from url
  if [ ! -d "$git_folder/$repo_name" ]; then # Check if directory already exists
  echo "Cloning $repo_name from $repo_url... - $(get_timestamp)" | tee -a $logg
  #sudo git clone "repo_url" "$git_folder/$repo_name" || { echo "Failed to clone $repo_name"; exit 1; } # Clone repo and handle errors
  sudo git clone "$repo_url" "$git_folder/$repo_name" || { echo "Failed to clone $repo_name"; exit 1; } # Clone repo and handle errors
  else
  	echo "Repo $repo_name already cloned at $git_folder/$repo_name. - $(get_timestamp)" | tee -a $logg
  fi 
done

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Special Git installs:

# Special install for mardkdown_live_preview:
if ! command -v markdown-live-preview >/dev/null 2>&1; then
    echo "markdown-live-preview not found. Installing ..."
    cd $git_folder
    cd markdown-live-preview && sudo chmod 777 markdown-live-preview
    make setup && make build
    echo "Installed markdown_live_preview at: $PWD - $(get_timestamp)" | tee -a $logg
else
    echo "markdown-live-preview is already installed - $(get_timestamp)" | tee -a $logg
    cd $git_folder
fi


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Python installs

# Start python install of updog
cd $git_folder
pipx install updog
echo "PIP installed updog - $(get_timestamp)" | tee -a $logg
cd $git_folder

#Start python install of PXEThief
cd $git_folder && sudo chmod 777 PXEThief
cd PXEThief
pip install -r requirements.txt
echo "Installed PXEThief at: $PWD  - $(get_timestamp)" | tee -a $logg
cd $git_folder

# Special install for grip:
# grips is a Python-based cli utility that renders Markdown files exactly like GitHub does, even using GitHub's own CSS for pixel-perfect accuracy.
cd $git_folder
pipx install grip
echo "PIP installed grip at: $PWD - $(get_timestamp)" | tee -a $logg
cd $git_folder


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Golang installs:

##########################################
##########################################
# Install command logger

sudo mkdir $HOME/log && sudo chmod 777 $HOME/log
cd $git_folder/2025_cmd_logr
sudo chmod +x Jul2025Ver.sh
./Jul2025Ver.sh


echo "Installed Jul2025Ver.sh install CLI logger from: $PWD - $(get_timestamp)" | tee -a $logg
cd $git_folder

################
# Install More_dots bashrc/zshrc custom dot files
cd $git_folder
cd More_dots
sudo chmod 777 add_aliases.sh
./add_aliases.sh
echo "Installed 'add_aliases.sh' at: $PWD - $(get_timestamp)" | tee -a $logg
cd $git_folder

################
# Install cheat_helper personalized cheats
cd $git_folder
cd cheat_helper
sudo chmod 777 personal_cheatsheets.sh
./personal_cheatsheets.sh
echo "Installed 'personal_cheatsheets.sh' at: $PWD - $(get_timestamp)" | tee -a $logg
cd $git_folder

echo "Install completed - $(get_timestamp)" | tee -a $logg

#https://freeipa-pentesting.popdocs.net/



