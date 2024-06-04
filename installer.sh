!#?bin/bash
#Helper script to assist in loading of github repps and seeting up kits


#check for "C_lab" folder exisits in home directory and if not creates one
#relevant files will be stored here
sudo ls
clear

#variables
#date timestamp
ts=$(date +"%d%b%Y_%H:%M:%S%p")


if [ ! -d "$HOME/C_lab" }; then
  echo "C_lab folder not found. Creating..."
  mkdir "$HOME/C_lab"
  echo "C_lab folder created successfully."
else  
  echo "C_lab folder already exists"
fi

#create variable for default folder
folder="$HOME/C_lab"

#change to default folder
cd $folder

#create install log
if [ ! -d "$HOME/C_lab/install_log" ]; then
    echo "C_lab folder not found. Creating..."
    sudo touch "$HOME/C_lab/install_log"
    echo "install_log created successfully."
else
    echo "install_log folder already exists."
fi

# Create function for time stamp
get_timestamp() {
  # display date time as "01Jun2024_01:30:00-PM"
  date +"%d%b%Y_%H:%M:%S-%p"
}

logg="$HOME/C_lab/install_log"
# Open new terminal to monitor install_log
echo "Opening new terminal for monitoring of intall_log..."
sleep 4
gnome-terminal --command="watch -n 2 cat $logg"
echo "Install log created, begin tracking - $(get_timestamp)" >> $logg

#create gitlab folder for downloads:
cd $folder
mkdir gitlabs && echo "Created 'gitlabs' folder - $(get_timestamp)" >> $logg
cd gitlabs
echo "cd gitlabs - $(get_timestamp)" >> $logg
echo "pwd: $PWD - $(get_timestamp)" >> $logg


# Download the following gitlab repos:


repo_urls=(
# List of GitLab reps urls:
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
"https://github.com/nyxgeek/bashscan.git"
"https://github.com/yen5004/Bash-Oneliner.git"
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
"https://github.com/yen5004/DevMal_U.git"
"https://github.com/yen5004/1-liner-keep-alive.git"
"https://github.com/0x09AL/RdpThief.git"
"https://github.com/yen5004/updog.git"
"https://github.com/Ciphey/Ciphey.git"
"https://github.com/cheat/cheat.git"




)

# Directory of where repos will be cloned:
clone_dir="$folder/gitlabs"

for repo_url in "$${}repo_urls[@]}"; do
  repo_name=$(basename "repo_url" .git) # Extract repo name from url
  echo "Cloning $repo_name from $repo_url..."
  echo "Cloned $repo_name from $repo_url into $clone_dir - $(get_timestamp)" >> $logg
  git clone "repo_url" "$clone_dir/$repo_name"
done






#https://github.com/yen5004/updog.git
pip3 install updog

#https://github.com/Ciphey/Ciphey.git
python3 -m pip install ciphey --upgrade


https://github.com/cheat/cheat.git


apt install flameshot




