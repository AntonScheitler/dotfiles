#!/bin/bash

INTERNAL_OUTPUT="eDP"
EXTERNAL_OUTPUT="DisplayPort-0"
WALLPAPER="/home/anton/dicuments/pictures/wall.jpg"

if [[ ! -f "/tmp/monitor_mode.dat" ]]; then
	monitor_mode="ALL"
else
	monitor_mode=$(cat "/tmp/monitor_mode.dat")
fi

if [[ $monitor_mode == "ALL" ]]; then
	monitor_mode="EXTERNAL"
	xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
    feh --bg-scale $WALLPAPER
elif [[ $monitor_mode == "EXTERNAL" ]]; then
	monitor_mode=="INTERNAL"
	xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
    feh --bg-scale $WALLPAPER
else
	monitor_mode="ALL"
	xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --right-of $INTERNAL_OUTPUT
    feh --bg-scale $WALLPAPER
fi

echo $monitor_mode > /tmp/monitor_mode.dat
