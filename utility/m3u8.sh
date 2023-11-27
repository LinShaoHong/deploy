#!/bin/bash

function func() {
  mkdir $1
  mv $1'.mp4' ./$1
  ffmpeg -i ./$1/$1'.mp4' -ss 00:00:02 -frames:v 1 ./$1/post.jpg
  ffmpeg -t 5 -i ./$1/$1'.mp4' -acodec copy ./$1/review.mp4
  ffmpeg -i ./$1/review.mp4 -c:v h264 -flags +cgop -g 30 -hls_time 5 -hls_list_size 0 -hls_segment_filename ./$1/review%3d.ts ./$1/review.m3u8
  ffmpeg -i ./$1/$1'.mp4' -c:v h264 -flags +cgop -g 30 -hls_time 5 -hls_list_size 0 -hls_segment_filename ./$1/index%3d.ts ./$1/index.m3u8
  rm -rf ./$1/review.mp4
  rm -rf ./$1/$1'.mp4'
}

export -f func

find ./ -maxdepth 1 -type f -name "*.mp4" | xargs -n1 basename | cut -d . -f1 | xargs -n1  bash -c 'func $@' _