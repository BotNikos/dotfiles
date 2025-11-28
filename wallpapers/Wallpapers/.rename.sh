#! /usr/bin/bash

path=~/Wallpapers

i=0

for image in $path/*.png $path/*.jpg
do
    i=$(expr $i + 1)
    mv $image $path/test_$i.png
    echo $image $path/test_$i.png
done

i=0
for image in $path/*.png
do
    i=$(expr $i + 1)
    mv $image $path/$i.png
    echo $image $path/$i.png
done

