#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/PDF Expert.app"
dockutil --no-restart --add "/Applications/Rstudio.app"
dockutil --no-restart --add "$(brew info emacs-plus | sed -n 2p | cut -d " " -f1)/Emacs.app"
dockutil --no-restart --add "/Applications/texstudio.app"
dockutil --no-restart --add "/Applications/System Preferences.app"

killall Dock
