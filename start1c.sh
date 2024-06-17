#!/bin/bash

portServer=$1'40'
portCluster=$1'41'
portRAS=$1'45'
portRPHost=$1'60:'$1'90'

rm -rf /home/usr1cv8/.1cv8/1C/1cv8/reg_1641/snc*
/opt/1cv8/x86_64/$ver1c/ragent -d /home/usr1cv8/.1cv8/1C/1cv8 -port $portServer -regport $portCluster -range $portRPHost -seclev 0 -pingPeriod 1000 -pingTimeout 5000 & \
/opt/1cv8/x86_64/$ver1c/ras cluster --port=$portRAS localhost:$portServer & \
/opt/1C/licence/3.0/licenceserver -a & \
sleep 60 && /usr/sbin/apachectl start &
wait
