#!/bin/bash

function func() {
  mkdir -p mp4tmp
  mv $1'.mp4' ./mp4tmp
  ffmpeg -i './mp4tmp/'$1'.mp4' -vcodec h264 './'$1.mp4
}

export -f func

find ./ -maxdepth 1 -type f  -name "*.mp4" | xargs -n1 basename | cut -d . -f1 | xargs -n1  bash -c 'func $@' _