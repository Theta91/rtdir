#!/bin/bash

################################################################################
case "$1" in
  "" | "-h" | "--help" )
    echo -e "Usage:"
    echo -e "  rtdir.sh [search string] [new path]\n"

    echo -e "[search string] can be anything from a tracker to a perl regular expression"
    echo -e "[new path] is the destination of the torrent files matched by [search string]"
    exit 0
  ;;
  * )
    regex="$1"
    new_base_path="${2%/}"
  ;;
esac
################################################################################

for i in $(grep -Pl "$regex" *.torrent); do
  base=$(grep -Po "directory([0-9]+:.+?)7:" "${i}.rtorrent")
  base="${base#directory}"
  base="${base%7:}"

  length="${base%%:*}"
  old_base_path="${base#*:}"
  old_base_path="${old_base_path%/*}"

  old_path="${base%/*}"
  diff=$(( ${#new_base_path} - ${#old_base_path} ))
  let "length += diff"
  new_path="$length:$new_base_path"
  sed -i "s#$old_path#$new_path#" "${i}.rtorrent"
done
