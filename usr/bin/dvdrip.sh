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
home="/media/Devildrive/movies/"
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
HandBrakeCLI -Z + AppleTV  -i /dev/sr0 -o $home$vlnm.mp4
