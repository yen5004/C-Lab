#!/bin/bash

# -----------------------------
# Command Logger Installer
# Created by: FM (refactored)
# Description: Adds logging and user info to .bashrc/.zshrc
# -----------------------------

# Prompt the user for their name
read -rp "Please enter your username: " name

# Create a config file to persist the username
CONFIG_FILE="$HOME/.cmd_logger_config"
echo "export NAME=\"$name\"" > "$CONFIG_FILE"

# Define the logging logic block to add to shell config files
# It includes:
# - Loading the username from config
# - Setting a custom prompt with timestamp (for zsh)
# - Starting a logging session using `script`, if not already running
# - Showing user info and IP details
# - Displaying a reminder to use EXIT
LOGGER_BLOCK='
# >>> Command Logger Setup >>>
[ -f "$HOME/.cmd_logger_config" ] && source "$HOME/.cmd_logger_config"

# Add timestamp to prompt in ZSH
if [ -n "$ZSH_VERSION" ]; then
    RPROMPT="[%D{%d%b%Y}|%D{%L:%M}]"
fi

# Start script logging if not already inside a `script` session
if [ "$(ps -ocommand= -p $PPID | awk '"'"'{print $1}'"'"')" != "script" ]; then
    mkdir -p "$HOME/log"
    script -a -f "$HOME/log/$(date +%F)_shell.log"
fi

# Show user and IP/network info
echo "User: $NAME"
if command -v ifconfig &>/dev/null; then
    ifconfig
else
    ip a
fi

# Show helpful reminder
note="Use EXIT to close Log Script"
echo "$note"
# <<< Command Logger Setup <<<
'

# Add the logger block to both .bashrc and .zshrc if not already present
for rc_file in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if ! grep -q "Command Logger Setup" "$rc_file"; then
        echo "$LOGGER_BLOCK" >> "$rc_file"
        echo "Logger block added to $rc_file"
    else
        echo "Logger block already exists in $rc_file"
    fi
done

echo "✅ Command logger installation complete!"
