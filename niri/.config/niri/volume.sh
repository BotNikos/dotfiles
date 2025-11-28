#!/usr/bin/env sh

# Get the volume level and convert it to a percentage
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume=$(echo "$volume" | awk '{print $2}')
volumePercent=$(echo "( $volume * 100 ) / 1" | bc)
volume=$(echo "( $volume * 10 ) / 1" | bc)

notify-send -t 2000 -a 'wp-vol' -h int:value:$volumePercent " ${volume}/10"
