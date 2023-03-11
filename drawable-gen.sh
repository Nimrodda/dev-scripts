#!/bin/sh
#---------------------------------------------------------------
# Given an xxhdpi image or an App Icon (launcher), this script
# creates different dpis resources and the necessary folders
# if they don't exist
#
# Place this script, as well as the source image, inside res
# folder and execute it passing the image filename as argument
#
# Example:
# ./drawables_dpis_creation.sh ic_launcher.png
# OR
# ./drawables_dpis_creation.sh my_cool_xxhdpi_image.png
#
# Copyright (c) 2016 Ricardo Romao.
# This free software comes with ABSOLUTELY NO WARRANTY and
# is distributed under GNU GPL v3 license. 
#---------------------------------------------------------------

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
else if [ -f "$1" ]; then
    echo " Creating different dimensions (dips) of "$1" ..."
    mkdir -p drawable-xxxhdpi
    mkdir -p drawable-xxhdpi
    mkdir -p drawable-xhdpi
    mkdir -p drawable-hdpi
    mkdir -p drawable-mdpi

    if [ $1 = "ic_launcher.png" ]; then
        echo "  App icon detected"
        convert ic_launcher.png -resize 144x144 drawable-xxhdpi/ic_launcher.png
        convert ic_launcher.png -resize 96x96 drawable-xhdpi/ic_launcher.png
        convert ic_launcher.png -resize 72x72 drawable-hdpi/ic_launcher.png
        convert ic_launcher.png -resize 48x48 drawable-mdpi/ic_launcher.png
        rm -i ic_launcher.png
    else
        FILENAME=`basename $1`
        convert $1 -resize 75% drawable-xhdpi/$FILENAME
        convert $1 -resize 50% drawable-hdpi/$FILENAME
        convert $1 -resize 25% drawable-mdpi/$FILENAME
        cp $1 drawable-xxhdpi/$FILENAME
    fi
echo " Done"
else
    echo "$1 not found."
fi
fi
