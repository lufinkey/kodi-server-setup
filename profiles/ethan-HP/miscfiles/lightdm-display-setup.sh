#!/bin/bash
if [ -n "$(xrandr | grep '^VGA-0 connected ')" ]
then
	xrandr --output LVDS --off
	xrandr --output VGA-0 --primary --auto
fi

