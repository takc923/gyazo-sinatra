#!/bin/sh
set -e

HASH=$1

/usr/local/bin/ffmpeg -i /tmp/${HASH}.mp4 -r 10 /tmp/${HASH}_%04d.png
/usr/local/bin/gm convert -delay 20 /tmp/${HASH}_*.png /Users/takc923/Workspace/gyazo-sinatra/public/images/${HASH}.gif
rm -f /tmp/${HASH}*

