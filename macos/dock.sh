#!/bin/sh

# Applications
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/Zotero.app"
dockutil --no-restart --add "/Applications/PDF Expert.app"
#dockutil --no-restart --add "/Applications/Rstudio.app"
dockutil --no-restart --add "$(brew info emacs-plus | sed -n 2p | cut -d " " -f1)/Emacs.app"
#dockutil --no-restart --add "/Applications/texstudio.app"
dockutil --no-restart --add "/Applications/System Preferences.app"

# Folders
dockutil --no-restart --add "/" --display folder
dockutil --no-restart --add "~/Downloads" --view fan --display stack --sort  datecreated

killall Dock
