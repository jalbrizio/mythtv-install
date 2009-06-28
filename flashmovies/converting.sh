#!/bin/bash
#env variables
home="/var/www/html/mythweb/data/"
#convertdir="/var/www/html/mythweb/data/dropbox/"
convertdir=$1
moved="/var/www/html/mythweb/data/moved/"
flmovies="/var/www/html/mythweb/data/flmovies/"
streams="/var/www/html/mythweb/data/streams/"
#export the variables
export home
export convertdir
export moved
export flmovies
export streams
#finding the files.
#filename=`ls $convertdir | tail -1`
filename=$2
export filename
#copy the test.php file and make a new one for the movie.
cat /var/www/html/mythweb/data/test2.php | sed s/xxxxx/$filename/g | sed s/.avi//g | sed s/yyyyy/$filename.flv/g > $streams/$filename.php
#convert the file to low Quality.
#/usr/bin/ffmpeg -y -i $convertdir/$filename -s 320x240 -r 24 -f flv -ac 2 -ar 11025 -ab 64k -b 256k "$flmovies/$filename".flv;
/usr/bin/ffmpeg -y -i $convertdir/$filename -s 720x304 -r 24 -f flv -ac 2 -ar 11025 -ab 64k -b 256k "$flmovies/$filename".flv;
#Convert the file to High Quality.
#/usr/bin/ffmpeg -y -i $convertdir/$filename  -ar 22050 -qscale 1 -f flv "$flmovies/$filename".flv;
#Convert the file to Medium Quality.
#/usr/bin/ffmpeg -y -i $convertdir/$filename  -ar 22050 -ab 96k -qscale 2 -f flv "$flmovies/$filename".flv;
#convert the file to low Quality.
#/usr/bin/ffmpeg -y -i $convertdir/$filename  -ar 11025 -ab 64k -qscale 12 -f flv -b 256k "$flmovies/$filename".flv;
