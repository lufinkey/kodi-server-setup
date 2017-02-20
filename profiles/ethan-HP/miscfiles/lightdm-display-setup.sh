#!/bin/bash
if [ -n "$(xrandr | grep '^VGA-0 connected ')" ]
then
	xrandr --output VGA-0 --primary --auto
	xrandr --output LVDS --off
fi
