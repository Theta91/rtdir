WARNING
=======
I want to emphasize that this script has the potential to fuck up your torrents
-------------------------------------------------------------------------------
really badly. I haven't had it fail on me, but you should back up your rtorrent
-------------------------------------------------------------------------------
session directory before even thinking of executing this script.
----------------------------------------------------------------

rtdir.sh changes the seeding directory of your files based on a search string,
such as a tracker, which can be a regular expression. It should be run in your
rtorrent session directory, while rtorrent is closed. As always, do a backup
beforehand.

Usage
-----
Run this script in rtorrent's session directory (or a backup thereof). Provide a
search string and a new path (escaped or quoted as necessary); thus the command
will look like `rtdir.sh [search string] [new path]`

The search string is applied to the *.torrent files in rtorrent's session
directory. The only real information available in those files is the tracker,
folder name, and contents of the torrent. If you'd like to change paths based on
some other metric, such as time finished or current directory, you must change
line 37, so that the search is applied to *.rtorrent.

If you want to see what your edits are going to do beforehand, simply remove the
-i switch from sed.
