#! /bin/sh
kbd="$(setxkbmap -query | grep layout | awk '{print $2}')"

if [ $kbd == 'dvorak' ]; then
    echo "DV"

else
    echo "SE"
fi

exit 0
