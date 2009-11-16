#!/bin/bash
#This script is to install or upgrade mythtv on a fedora server
# mythupgrage v3.1
#
#here are the files affected
#/etc/yum.repos.d/atrpms.repo
#/etc/yum.repos.d/freshrpms.repo
#/usr/sbin/mythtvbackout
#/usr/bin/mythshutdown
#/sbin/mythtv-start
#/sbin/mythtv-start1
#/usr/bin/mythtv-startup
#~/change-channel-lirc.pl 
#~/lircrc
#~/.lircrc
#./.lircrc.good
#~/.xine/keymap
#/etc/lircd3.conf.sa2200
#/etc/lircd.conf 
#/etc/lircd.conf.good 
#/etc/lircd.conf.sa2000
#/etc/lircd.conf.sa2200 
#/etc/lircd.conf.sa3200
#/etc/lircd.conf.sa3250
#/etc/lircd.test 
#/etc/lircrc 
#/sbin/init.d/mythtv-start
#
# 
#
#First enter your Fedora version ie 9 10 11 or 12. only enter the number.
echo "enter your Fedora version ie 9 10 11 or 12. only enter the number."
echo -n "fedoraversion: "

stty -echo
read fedoraversion
stty echo

echo ""         # force a carriage return to be output
echo You entered $fedoraversion

#Now enter your Fedora arch ie i386 ppc  or x86_64.
echo "enter your Fedora arch ie i386 ppc  or x86_64."
echo -n "fedoraarch: "

stty -echo
read fedoraarch
stty echo

echo ""         # force a carriage return to be output
echo You entered $fedoraarch
 
#now enter your mysql username and password. this will be used later.
echo "enter your mysql root password."
echo -n "mysqlrootpw: "

stty -echo
read mysqlrootpw
stty echo

echo ""         # force a carriage return to be output
echo You entered $mysqlrootpw
#
echo "the default user we are using is mythy you chan change that user later if you like."
echo "enter mythy's password."
echo -n "mythypw: "

stty -echo
read mythypw
stty echo

echo ""         # force a carriage return to be output
echo You entered $mythypw
#

#Now lets get your box up to date

yum -y install yum-fastestmirror;
yum clean all;
yum -y --disablerepo=atrpm* --disablerepo=freshrpm* --disablerepo=rpmfusion* update;
yum clean all;
#
#
#
#lets install the 3rd party repos needed.
#
#
#rpmfusion its now needed for freshrpms.
rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
rpm -ivh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm
#Atrps

rpm -ivh http://dl.atrpms.net/f$fedoraversion-$fedoraarch/atrpms/stable/atrpms-repo-$fedoraversion-2.fc$fedoraversion.i586.rpm
rpm -ivh http://dl.atrpms.net/f$fedoraversion-$fedoraarch/atrpms/stable/atrpms-repo-$fedoraversion-2.fc$fedoraversion.$fedoraarch.rpm
#
#Freshrpms

#rpm -ivh http://ftp.freshrpms.net/pub/freshrpms/fedora/linux/$fedoraversion/freshrpms-release/freshrpms-release-1.*-1.fc.noarch.rpm;

wget -r -l0 --no-parent -A *.rpm http://ftp.freshrpms.net/pub/freshrpms/fedora/linux/$fedoraversion/freshrpms-release/
sleep 30
FRESHRPM=`find ./ftp.freshrpms.net -name *.rpm | grep noarch`
rpm -ivh $FRESHRPM
sleep 10
yum -y remove python-imaging;
yum -y install mythtv-suite;
#yum -y install myth*them*;
#yum -y install them*myth*;
#yum -y install xmame
#yum -y install xmame-roms
#
# OK so now lets make the user and group

groupadd mythy
useradd mythy -c "mythtv user" -d /home/mythy -g mythy -G mythy,root -m -k /etc/skel/ 
#
#now lets unpack everything and get it configured properly.

tar -xvf ./mythtv.tar.bz2 /
#
#this will also keep the permissions set properly
#if not just in case lets run fix everything at the end.
#
#now lets set some env veriables fo mysql now that your software is installed.
DEFDB=`rpm -ql mythtv-docs | grep sql`
#setting up mysql ******correctly*****.

/sbin/chkconfig mysqld on
/sbin/service mysqld start 
#creating the mysql file needed.
#
echo "UPDATE user SET Password=PASSWORD('$mysqlrootpw') WHERE user='root';" >mysqlconfig.sql
echo "FLUSH PRIVILEGES;" >>mysqlconfig.sql
echo "CREATE USER 'mythy'@'%' IDENTIFIED BY '$mythypw';" >>mysqlconfig.sql
echo "GRANT ALL PRIVILEGES ON *.* TO 'mythy'@'localhost'" >>mysqlconfig.sql
echo "WITH GRANT OPTION;" >>mysqlconfig.sql
echo "GRANT ALL PRIVILEGES ON *.* TO 'mythy'@'%'" >>mysqlconfig.sql
echo "WITH GRANT OPTION;" >>mysqlconfig.sql
echo "UPDATE user SET Password=PASSWORD('$mythypw') WHERE user='mythy';" >>mysqlconfig.sql
echo "FLUSH PRIVILEGES;" >>mysqlconfig.sql

#running the file 
mysql -u root -p$mysqlrootpw mysql < mysqlconfig.sql
sleep 3
# now deleteeing the file so we dont store you password.
rm mysqlconfig.sql
#find /usr/share/ -name mc.sql | sed s/$/mysql\ -u\ root\ -p\ mythtvpassword\ mythconverg \<\  
#sh /mythtv/mythupgrade/update.txt
#mysql -u root -p $mythtvpassword mythconverg <  /mythtv/mythupgrade/mythtv-customize.sql
mysql -u root -p$mysqlrootpw mythconverg <  $DEFDB
#
#
#
#ok so just in case everything is not set properly we are running a special script 
#
echo "add this to cron if you want to optimize your tables."
ech "0 1 * * *  /usr/bin/mysql -uroot -pmysqlrootpw mythconverg < /usr/lib/mythoptimize.sql > /var/log/mythoptimize.log"
sleep 2
echo "running fix_everything.now"
chmod 777 /var/run/ivman.pid
echo " cleaning up "
rm -rf ./ftp.freshrpms.net 
sleep 1
echo "All done, have fun with your new pvr"
EOF
#
