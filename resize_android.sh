#!/bin/bash

# Check if an argument is given
if [ $# -eq 0 ]; then
    echo "Usage: $0 <image.png>"
    exit 1
fi

# Android density scale factors
# xxxhdpi : 4.0x
# xxhdpi  : 3.0x
# xhdpi   : 2.0x
# hdpi    : 1.5x
# mdpi    : 1.0x (base density)
# ldpi    : 0.75x

input_image=$1
base_name=$(basename "$input_image" .png)

# Function to resize image
resize_image() {
    local input=$1
    local density=$2
    local scale=$3

    # Create folder if it doesn't exist
    mkdir -p "res/drawable-${density}"

    # Set output image path
    local output="res/drawable-${density}/${base_name}.png"

    # Resize and save image
    if [ "$scale" = "100" ]; then
        cp "$input" "$output"
    else
        convert "$input" -resize "$scale%" "$output"
    fi
    echo "Generated $output"
}

# Copying and resizing to different densities
resize_image "$input_image" "xxxhdpi" 100   # Original size for xxxhdpi
resize_image "$input_image" "xxhdpi" 75    # 3.0x of mdpi (75% of xxxhdpi)
resize_image "$input_image" "xhdpi" 50     # 2.0x of mdpi (50% of xxxhdpi)
resize_image "$input_image" "hdpi" 37.5    # 1.5x of mdpi (37.5% of xxxhdpi)
resize_image "$input_image" "mdpi" 25      # 1.0x of mdpi (25% of xxxhdpi)
