#!/bin/bash

INTERNAL_OUTPUT="eDP"
EXTERNAL_OUTPUT="HDMI-A-0"
#WALLPAPER="/home/anton/Pictures/dog.jpg"

if [[ ! -f "/tmp/monitor_mode.dat" ]]; then
	monitor_mode="ALL"
else
	monitor_mode=$(cat "/tmp/monitor_mode.dat")
fi

if [[ $monitor_mode == "ALL" ]]; then
	monitor_mode="EXTERNAL"
	xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto # adjust the background image
    #feh --bg-scale $WALLPAPER
elif [[ $monitor_mode == "EXTERNAL" ]]; then
	monitor_mode=="INTERNAL"
	xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off # adjust the background image
    #feh --bg-scale $WALLPAPER
else
	monitor_mode="ALL"
	xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --right-of $INTERNAL_OUTPUT # adjust the background image
    #feh --bg-scale $WALLPAPER
fi

echo $monitor_mode > /tmp/monitor_mode.dat
