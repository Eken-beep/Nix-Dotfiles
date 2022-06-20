#!/run/current-system/sw/bin/zsh
# Setting the layout variable with the current variable
layout="$(setxkbmap -query | grep layout | awk '{print $2}')"

# Setting the correct layout
if [ $layout == 'dvorak' ]; then
	setxkbmap se svdvorak
else
	setxkbmap dvorak
fi

# Ded
exit 0
