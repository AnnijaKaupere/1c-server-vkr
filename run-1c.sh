#!/bin/bash

ver1c=$1
if [[ $ver1c = '' ]]; then
        echo "Version !!!"
	exit 1
fi

startPort=$2'40'
if [[ $startPort = '' ]]; then
        echo "Port !!!"
        exit 1
fi
nameDock=$startPort'-'$3

portParam=${startPort:0:2}

endPort=$portParam'79'
httpPort=$portParam'80'
slkPort=$portParam'91'

runCom="docker run --restart always -ti -d --name $nameDock \
	-v /root/1c_clusters/$nameDock/usr1cv8:/home/usr1cv8 \
	-v /root/1c_clusters/$nameDock/1cpub:/etc/apache2/1cpub \
	-v /root/1c_clusters/$nameDock/licenses:/var/1C/licenses \
	-v /apdex/$nameDock:/home/usr1cv8/apdex \
	-v /mnt/filestore/$nameDock:/mnt/filestore \
	-v /root/1c_clusters/z_command:/z_command \
	-p $startPort-$endPort:$startPort-$endPort \
	-p $httpPort:80 \
	-p $slkPort:9099 \
	-h 1c-docker \
	1c-server:$ver1c ./start1c.sh $portParam"

echo $runCom
/bin/bash -c "$runCom"
