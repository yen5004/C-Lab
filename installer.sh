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
echo "Install log created, begin tracking - $(get_timestamp)" >> $logg

#create gitlab folder for downloads:
mkdir gitlabs && echo "Created 'gitlabs' folder - $(get_timestamp)" >> $logg
cd gitlabs





















