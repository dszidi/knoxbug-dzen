#!/usr/local/bin/bash

(echo "^bg('#333333')^fg('#ffffff')  Applications"; echo "    inkscape";echo "    firefox"; echo "    chrome"; sleep 20) | dzen2 -bg '#efefef' -fg '#333333' -fn 'Roboto:Medium:15px' -x 0 -y 0 -ta l -tw 175 -w 175 -l 3 -m -xs 3
