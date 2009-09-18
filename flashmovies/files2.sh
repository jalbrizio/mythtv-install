#files2.sh
#!/bin/bash
moved="/var/www/html/mythweb/data/moved/"
flmovies="/var/www/html/mythweb/data/flmovies/"
streams="/var/www/html/mythweb/data/streams/"
filename=$1
filepath=`find /media/Devildrive/movies/ -name $filename`
#copy the test.php file and make a new one for the movie.
cat ./test2.php | sed s/xxxxx/$filename/g | sed s/.avi//g | sed s/yyyyy/$filename.flv/g | sed s/zzzzz/$filename.n800.php/g > $streams/$filename.php
cat ./test3.php | sed s/xxxxx/$filename/g | sed s/.avi//g | sed s/yyyyy/$filename.flv/g | sed s/zzzzz/$filename.n800.php/g > $streams/$filename.n800.php
#convert the file to low Quality.
/usr/bin/ffmpeg -y -i $filepath -s 720x304 -r 24 -qscale 10 -f flv -ac 2 -ar 11025 -ab 64k -b 256k "$flmovies/$filename".flv;
