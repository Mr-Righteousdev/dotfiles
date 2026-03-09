#!/bin/bash

# Powermenu options
options=" Lock\n Shutdown\n Reboot\n Logout\n Cancel"

# Show rofi with powermenu options
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -config ~/.config/rofi/config/powermenu.rasi)

case $chosen in
    " Lock")
        i3lock --nofork
        ;;
    " Shutdown")
        systemctl poweroff
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Logout")
        i3-msg exit
        ;;
    " Cancel")
        exit 0
        ;;
esac