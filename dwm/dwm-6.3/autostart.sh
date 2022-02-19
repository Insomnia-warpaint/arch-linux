#!/bin/sh

#dwmblocks
dwmblocks &

#stop cgproxy
systemctl stop cgproxy &

# wallpaper
feh  --bg-fill ~/.wallpaper/wallpaper-1008.jpg &

#comptom
compton --config ~/.config/compton/compton.conf &

#nm-applet
nm-applet &

#fcitx5
fcitx5 &

#ablert
albert &

