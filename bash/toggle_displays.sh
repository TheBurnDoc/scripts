#!/bin/sh
if xrandr --listactivemonitors | grep "HDMI-A-0"; then
    xrandr --output DisplayPort-0 --primary --mode 3440x1440 --pos 0x0 --rate 144 --output HDMI-A-0 --off
else
    xrandr --output DisplayPort-0 --off --output HDMI-A-0 --primary --mode 3840x2160 --pos 0x0 --rate 120
fi
