!#/bin/bash
#Helper script to assist in the loading of GitHub repos and setting up kits

#relevant files will be stored here
sudo ls # get sudo before we start
echo "Clearing screen before we start..."
sleep 4 && clear

# Declare variables
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Create a function for timestamp
get_timestamp() {
  # display date time as "01Jun2024_01:30:00-PM"
  date +"%d%b%Y_%H:%M:%S-%p"
}

#########################  #########################  #########################
#########################  #########################  #########################
#########################  #########################  #########################
#add the following:
#
#sudo apt-get install htop
#sudo apt-get install cowsay
#sudo apt-get install cmatrix

#
#########################  #########################  #########################
#########################  #########################  #########################
#########################  #########################  #########################


#create a variable for the default folder
project="C_lab"
folder="$HOME/$project"

#check to see if the "project" folder exists in the home directory, and if not, create one
if [ ! -d "$folder" }; then
  echo "$project folder not found. Creating..."
  mkdir "$folder"
  echo "$project folder created successfully."
else  
  echo "$project folder already exists."
fi

#change to the default folder
cd $folder

#create install log
if [ ! -d "$folder/install_log" ]; then
    echo "$project folder not found. Creating..."
    sudo touch "$folder/install_log"
    echo "install_log created successfully."
else
    echo "install_log folder already exists."
fi

echo "Install log created, begin tracking - $(get_timestamp)" >> $logg

logg="$HOME/$project/install_log"
# Open a new terminal to monitor install_log
echo "Opening new terminal for monitoring of install_log..."
sleep 4
gnome-terminal --command="watch -n 2 cat $logg"
echo "Install log created, begin tracking - $(get_timestamp)" >> $logg

# Update and upgrade machine
echo "Start machine update & full upgrade - $(get_timestamp)" >> $logg
#sudo apt update -y && sudo apt upgrade -y #for normal updates
sudo apt update -y && sudo apt full-upgrade -y #everything upgrade
echo "Finish machine update & full upgrade - $(get_timestamp)" >> $logg

# Check to see if "gitlab" folder exists in the project directory, and if not, creates one
# Create github folder for downloads:
git_folder="$HOME/$folder/gitlab"
if [ ! -d "$git_folder" }; then
  echo "$git_folder folder not found. Creating..."
  mkdir "$git_folder"
  echo "$git_folder folder created successfully." && echo "$git_folder folder created successfully - $(get_timestamp)" >> $logg
else  
  echo "$git_folder folder already exists" && echo "$git_folder folder already exists - $(get_timestamp)" >> $logg
fi

cd $git_folder && "echo cd $git_folder - $(get_timestamp)" >> $logg && echo "pwd: $PWD - $(get_timestamp)" >> $logg

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Download the following gitlab repos:
repo_urls=(
# List of GitLab reps urls:
"https://github.com/nyxgeek/bashscan.git"
"https://github.com/dafthack/SharpUp.git"
"https://github.com/Hack-the-box/PowerShellMafia.git"
"https://github.com/dafthack/HostRecon.git"
"https://github.com/dafthack/RDPSpray.git"
"https://github.com/dafthack/Misc-Powershell-Scripts.git"
"https://github.com/frizb/MSF-Venom-Cheatsheet.git"
"https://github.com/swisskyrepo/PayloadsAllTheThings.git"
"https://github.com/initstring/uptux.git"
"https://github.com/Hack-the-box/unicorn.git"
"https://github.com/andrewjkerr/security-cheatsheets.git"
"https://github.com/0x09AL/RdpThief.git"
"https://github.com/Ciphey/Ciphey.git"
"https://github.com/cheat/cheat.git"
"https://github.com/gchq/CyberChef.git"
"https://github.com/Tylous/ScareCrow.git"
"https://github.com/burrowers/garble.git"
"https://github.com/tanabe/markdown-live-preview.git"
"https://github.com/securisec/chepy.git"
"https://github.com/itm4n/PrivescCheck.git"
"https://github.com/topotam/PetitPotam.git"
"https://github.com/peass-ng/PEASS-ng.git"
"https://github.com/MWR-CyberSec/PXEThief.git"
"https://github.com/yck1509/ConfuserEx.git"
"https://github.com/yen5004/1-liner-ls--la-.git"
"https://github.com/yen5004/ZIP_TAR.git"
"https://github.com/yen5004/Encrypt_Decrypt.git"
"https://github.com/yen5004/Encode_Decode.git"
"https://github.com/yen5004/EICAR.git"
"https://github.com/yen5004/THM_BashScripting.git"
"https://github.com/yen5004/THM_ToolBox-Vim.git"
"https://github.com/yen5004/THM_AV_Evasion-Shellcode.git"
"https://github.com/yen5004/Hash_Hash.git"
"https://github.com/yen5004/SCP_file_sender.git"
"https://github.com/yen5004/tmux_quad_screen_user_input.git"
"https://github.com/yen5004/tmux_script.git"
"https://github.com/yen5004/Bash-Oneliner.git"
"https://github.com/yen5004/DevMal_U.git"
"https://github.com/yen5004/1-liner-keep-alive.git"
"https://github.com/yen5004/GitLab_help.git"
"https://github.com/yen5004/MagicNumbers.git"
"https://github.com/yen5004/updog.git"
""
""
""

)

# Directory of where repos will be cloned:
for repo_url in "${repo_urls[@]}"; do
  repo_name=$(basename "repo_url" .git) # Extract repo name from url
  echo "Cloning $repo_name from $repo_url..." && echo "Cloned $repo_name from $repo_url into $git_folder - $(get_timestamp)" >> $logg
  sudo git clone "repo_url" "$git_folder/$repo_name"
done

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Special instructions for gits:

# Special install for cheat:
cd $HOME && echo "cd home - $(get_timestamp)" >> $logg && echo "pwd: $PWD - $(get_timestamp)" >> $logg
echo "Start cheat install - $(get_timestamp)" >> $logg
cd /tmp \
  && wget https://github.com/cheat/cheat/releases/download/4.4.2/cheat-linux-amd64.gz \
  && gunzip cheat-linux-amd64.gz \
  && chmod +x cheat-linux-amd64 \
  && sudo mv cheat-linux-amd64 /usr/local/bin/cheat
echo "Clone & install cheat complete - $(get_timestamp)" >> $logg
echo "Setting up cheat for the first time, standby..." && echo "Setting up cheat - $(get_timestamp)" >> $logg
yes | cheat scp
echo "cheat set up cheat complete." && echo "cheat set up cheat complete - $(get_timestamp)" >> $logg
cd $HOME && echo "cd home - $(get_timestamp)" >> $logg && echo "pwd: $PWD - $(get_timestamp)" >> $logg

# Special install for CyberChef:
echo "Start CyberChef install" && echo "Start CyberChef install - $(get_timestamp)" >> $logg
cd $git_folder && echo "cd $PWD - $(get_timestamp)" >> $logg
cd CyberChef && echo "cd $PWD - $(get_timestamp)" >> $logg
sudo npm install
echo "export NODE_OPTIONS=--max_old_space_size=2048" >> ~/.bashrc
echo "Finish CyberChef install - $(get_timestamp)" >> $logg

#left off here
# Special install for ScareCrow:
echo "Start ScareCrow install" && echo "Start ScareCrow install - $(get_timestamp)" >> $logg
cd $git_folder && echo "cd $PWD - $(get_timestamp)" >> $logg
cd ScareCrow && echo "cd $PWD - $(get_timestamp)" >> $logg

# First ensure Golang is installed (ScareCrow cont.)
sudo apt install -y golang  && echo "sudo apt install -y golang - $(get_timestamp)" >> $logg

#Add the following lines to ~/.bashrc file:
echo "export GOROOT=/usr/lib/go" >> ~/.bashrc
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> ~/.bashrc

# Reload the .bashrc
source ~/.bashrc

# Create test program go Golang
touch HelloWorld_Go_Test.go
echo -e "package main\nimport \"fmt\"\nfunc main() {\n      fmt.Printf(\"GOlang install sucessful! Hello, world!\\n\")\n}" >> HelloWorld_Go_Test.go
go build Hello.go
sleep 5
echo "Golang install sucess! Continue with ScareCrow install"
echo "Golang install sucess! Continue with ScareCrow install - $(get_timestamp)" >> $logg 
go get github.com/fatih/color && echo "go get github.com fatih/color  - $(get_timestamp)" >> $logg
go get github.com/yeka/zip && echo "go get github.com yeka/zip  - $(get_timestamp)" >> $logg
go get github.com/josephspurrier/goversioninfo && echo "go get github.com josephspurrier/goversioninfo  - $(get_timestamp)" >> $logg
go get github.com/Binject/debug/pe && echo "go get github.com Binject/debug/pe - $(get_timestamp)" >> $logg
go get github.com/awgh/rawreader && echo "go get github.com  awgh/rawreader - $(get_timestamp)" >> $logg
sudo apt install -y openssl && echo "sudo apt install -y openssl  - $(get_timestamp)" >> $logg
sudo apt install -y osslsigncode && echo "sudo apt install -y osslsigncode  - $(get_timestamp)" >> $logg
sudo apt install -y mingw-w64 && echo "sudo apt install -y mingw-w64  - $(get_timestamp)" >> $logg

# Built it
go build ScareCrow.go
echo "Finish ScareCrow install" && echo "Finish ScareCrow install - $(get_timestamp)" >> $logg


# Special install for garble:
echo "Start garble install" && echo "Start garble install - $(get_timestamp)" >> $logg
cd $git_folder && echo "cd $git_folder - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
cd garble && echo "cd garble - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
go install mvdan.cc/garble@latest
echo "Finish garble install" && echo "Finish garble install - $(get_timestamp)" >> $logg

# Special install for garble:
echo "Start markdown_live_preview install" && echo "Start garble install - $(get_timestamp)" >> $logg
cd $git_folder && echo "cd $git_folder - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
cd markdown-live-preview && echo "cd markdown-live-preview - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
make setup && make build
echo "Finish markdown_live_preview install" && echo "Finish markdown_live_preview install - $(get_timestamp)" >> $logg

# Special install for pe-bear:
echo "Start pe-bear install" && echo "Start garble install - $(get_timestamp)" >> $logg
cd $git_folder && echo "cd $git_folder - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
sudo git clone --recursive https://github.com/hasherezade/pe-bear.git && echo "sudo git clone --recursive https://github.com/hasherezade/pe-bear.git - $(get_timestamp)" >> $logg
cd pe-bear && echo "cd pe-bear - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
./build_qt6.sh
echo "Finish pe-bear install" && echo "Finish pe-bear install - $(get_timestamp)" >> $logg

# Special install for Chepy:
echo "Start Chepy install" && echo "Start Chepy install - $(get_timestamp)" >> $logg
cd $git_folder && echo "cd $git_folder - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
cd chepy && echo "cd chepy - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
pip3 install -e
pip install .
pip install pyinstaller
pyinstaller cli.py --name chepy --onefile
echo "Finish Chepy install" && echo "Finish Chepy install - $(get_timestamp)" >> $logg

# Special install for Flamingo:
echo "Start Flamingo install" && echo "Start Flamingo install - $(get_timestamp)" >> $logg
cd $git_folder && echo "cd $git_folder - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
cd flamingo && echo "cd flamingo - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
go get -u -v github.com/atredispartners/flamingo
go install -v github.com/atredispartners/flamingo
echo "Finish Flamingo install" && echo "Finish Flamingo install - $(get_timestamp)" >> $logg







#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Python installs

# Start install of Ciphey
echo "Start python install of Ciphey..." && echo "Start python install of Ciphey - $(get_timestamp)" >> $logg
python3 -m pip install ciphey --upgrade
echo "Finish python install of Ciphey..." && echo "Fininsh python install of Ciphey - $(get_timestamp)" >> $logg

# Start install of updog
echo "Start python install of updog..." && echo "Start python install of updog - $(get_timestamp)" >> $logg
pip3 install updog
echo "Finish python install of updog..." && echo "Fininsh python install of updog - $(get_timestamp)" >> $logg

echo "Start python install of PXEThief..." && echo "Start python install of PXEThief - $(get_timestamp)" >> $logg
cd $git_folder && echo "cd $git_folder - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
cd flamingo && echo "cd PXEThief - $(get_timestamp)" >> $logg
pip install -r requirements.txt
echo "Finish python install of PXEThief..." && echo "Fininsh python install of PXEThief - $(get_timestamp)" >> $l




#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# apt install section
cd ~ && && echo "cd ~ - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
sudo apt install -y flameshot && echo "sudo apt install -y flameshot - $(get_timestamp)" >> $logg

cd ~ && && echo "cd ~ - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg
sudo apt install -y talk talkd && echo "sudo apt install -y talk talkd - $(get_timestamp)" >> $logg

#cd ~ && && echo "cd ~ - $(get_timestamp)" >> $logg
#echo "pwd: $PWD - $(get_timestamp)" >> $logg
#sudo apt install -y clamav && echo "sudo apt install -y clamav - $(get_timestamp)" >> $logg

cd ~ && && echo "cd ~ $PWD - $(get_timestamp)" >> $logg
sudo apt install -y pwncat && echo "sudo apt install -y pwncat - $(get_timestamp)" >> $logg






