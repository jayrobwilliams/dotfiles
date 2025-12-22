#!/bin/sh

# Applications
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/Kitty.app"
dockutil --no-restart --add "$(brew info emacs-plus | sed -n 2p | cut -d " " -f1)/Emacs.app"
dockutil --no-restart --add "/Applications/System Settings.app"

# Folders
dockutil --no-restart --add "/" --display folder
dockutil --no-restart --add "~/Downloads" --view fan --display stack --sort  datecreated

killall Dock
