#!/bin/bash
#version=4
#dvdrip.sh
#
#Depends on script files2.sh to convert the movies.
#
#lets start with environmental variables
#
#convertdir="/var/www/html/mythweb/data/dropbox/"#this is not used any more was only used in the first version.
#moved="/var/www/html/mythweb/data/moved/"#this is not used any more was only used in the first version.
#this is the root where all your movies are stored.
home="/media/drive/movies/"
#this is where you want all of your converted movies to be placed.
flmovies="/var/www/html/mythweb/data/flmovies/"
#this is where you want all of your web pages to be placed.
streams="/var/www/html/mythweb/data/streams/"
vlnm=`volname /dev/sr0 | sed s/\ //g`
#
#export the variables
#export convertdir
#export moved
export home
export flmovies
export streams
export vlnm
#
#s over.
#HandBrakeCLI -Z + AppleTV  -i /dev/sr0 -o $home$vlnm.mp4
#HandBrakeCLI ref=3:mixed-refs=1:bframes=3:b-adapt=2:direct=auto:weightb=1:b-pyramid=1:subq=7:analyse=all:no-fast-pskip=1 -i /dev/sr0 -o $home$vlnm.mp4
HandBrakeCLI -t 38 level=41:ref=6:mixed-refs=1:bframes=3:me=umh:analyse=all:no-fast-pskip=1:deblock=-2,-1:8x8dct=1:no-dct-decimate=1: -i /dev/sr0 -o $home$vlnm.mp4
