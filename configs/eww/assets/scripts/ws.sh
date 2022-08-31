#!/bin/sh
wmctrl -d | grep "*" | awk '{print $9}'
