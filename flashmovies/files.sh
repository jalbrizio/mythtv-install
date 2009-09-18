#!/bin/bash
#version=4
#files.sh
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
#
#export the variables
#export convertdir
#export moved
export home
export flmovies
export streams
#
#finding the files and creating a script to convert all of the files over.
> files1.1.sh
ls -Rl /media/Devildrive/movies/ | egrep '.3gp|.asf|.asx|.avi|.flv|.m4v|.mgv|.mkv|.mnv|.mov|.mp4|.mpeg|.mpg|.ogm|.oog|.qt|.rm|.nuv|.swf|.tivo|.vob|.wmv' | awk '{print $8}' | sed s/\ //g | sed /^$/d | sed s/^/.\\/files2.sh\ /g >files1.1.sh 
#
#finding the files already done and creating a script to remove them from the list of all files.
> files1.5.sh
ls -Rl $flmovies | egrep '.3gp|.asf|.asx|.avi|.flv|.m4v|.mgv|.mkv|.mnv|.mov|.mp4|.mpeg|.mpg|.ogm|.oog|.qt|.rm|.nuv|.swf|.tivo|.vob|.wmv' | awk '{print $8}' |sed /^$/d | sed s/.flv//g |sed s/^/\|/g |sed s/$/\|/g | sed -e :a -e N -e 's/\n//' -e ta | sed s/\|\|/\|/g | sed s/^/egrep\ -v\ \'/g | sed s/$/\'\ files1.1.sh\ \>\ files1.sh/g |sed s/\'\|/\'/g |sed s/\|\'/\'/g  > files1.5.sh
#
#Run the script to remove the completed files.
./files1.5.sh
#run the script to convert your movie format, this calls files2.sh
./files1.sh
