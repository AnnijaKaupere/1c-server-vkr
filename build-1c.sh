#!/bin/bash

ver1c=$1
if [[ $ver1c = '' ]]; then
	echo "Version !!!"
	exit 1
fi

docker build $2 -t '1c-server-slk-3033:'$ver1c --build-arg 'ver1c='$ver1c .
