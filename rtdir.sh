#!/bin/bash

################################################################################
#    Copyright (C) 2011 Someone                                                #
#                                                                              #
#    This program is free software: you can redistribute it and/or modify      #
#    it under the terms of the GNU General Public License as published by      #
#    the Free Software Foundation, either version 3 of the License, or         #
#    (at your option) any later version.                                       #
#                                                                              #
#    This program is distributed in the hope that it will be useful,           #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of            #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             #
#    GNU General Public License for more details.                              #
#                                                                              #
#    You should have received a copy of the GNU General Public License         #
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.     #
################################################################################

################################################################################
case "$1" in
  "" | "-h" | "--help" )
    echo -e "Usage:"
    echo -e "  rtdir.sh [search string] [new path]\n"

    echo -e "rtdir.sh changes the seeding directory of your files based on a search string,"
    echo -e "such as a tracker, which can be a regular expression. It should be run in your"
    echo -e "rtorrent session directory, while rtorrent is closed. As always, do a backup"
    echo -e "beforehand.\n"
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
