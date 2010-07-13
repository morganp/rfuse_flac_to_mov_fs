rfuse_flac_to_mov_fs
====================

Relies on fusefs (latest 0.7.0) gem.

This mounts the file system to the first Argument (folder is created automatically) and the second argument is the location to 'link to'.
This filesystem is designed to allow iTunes to play *.flac files by presenting them as *.mov files. Which iTunes can play if the [xiph components][xiph] are put in place '/Library/Components/XiphQT.component'

    $ rfuse_flac_to_mov_fs ~/Music_iTunes_flac ~/Music

[xiph]: http://xiph.org/quicktime/download.html
