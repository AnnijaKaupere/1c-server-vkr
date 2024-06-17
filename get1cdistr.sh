#!/bin/bash

ver1cnew=$ver1c
ver1="${ver1cnew//./_}"

smbauth='ARBIS-NEW/pve-backup%Selowyk('
distr='\\truenas\1c_techsupp\1c_enterprise82\'$ver1c'\server64_'$ver1'.tar.gz'
filename='server64_'$ver1'.tar.gz'


echo $distr
smbclient -U $smbauth //truenas/1c_techsupp/ --directory /1c_enterprise82/$ver1c -c "get $filename"
tar xvf $filename
rm $filename
chmod +x 'setup-full-'$ver1c'-x86_64.run'

mv 'setup-full-'$ver1c'-x86_64.run' 'setup-1c.run'
