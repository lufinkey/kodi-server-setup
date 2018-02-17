#!/bin/bash
if [ -n "$(xrandr | grep '^VGA-0 connected ')" ]
then
	xrandr --output LVDS --off
	xrandr --output HDMI-0 --primary --auto
fi

