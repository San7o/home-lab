#!/bin/sh
yt-dlp -x --audio-format mp3 -f bestaudio \
  --embed-metadata --embed-thumbnail \
  -o "%(artist,uploader)s/%(album,playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s" \
  $1
