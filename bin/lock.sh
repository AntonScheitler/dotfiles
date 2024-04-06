#!/bin/bash

imgpath="/tmp/i3lock.png"
screenshot="scrot $imgpath"

blurtype="0x7"

$screenshot
convert $imgpath -blur $blurtype $imgpath
i3lock -i $imgpath
rm $imgpath
