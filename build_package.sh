#!/bin/bash

if [ ! $(which fpm) ]; then
	echo "fpm is required to run debian packaging"
	# make sure we are running in a legitimate user environment
	ME=$(whoami)
	if [[ "$ME" == "root" ]]; then
		echo "please don't run me as root"
		exit 1
	fi

	# Run script as sudo
	sudo echo "thanks for admin priviliges"

	apt-get install ruby ruby-dev rubygems build-essential
	gem install --no-ri --no-rdoc fpm
fi;

if [ $(find -name "nonlibc_0.2.2_amd64.deb") ]; then
	rm nonlibc_0.2.2_amd64.deb
fi;

# create the package
 fpm -s dir -t deb -n nonlibc -v 0.2.2 \
	 src/libnonlibc.a=/usr/local/lib/arm-linux-gnueabihf/libnonlibc.a \
	 src/libnonlibc.so=/usr/lib/arm-linux-gnueabihf/libnonlibc.so \
	 util/fnvsum=/usr/local/bin/fnvsum \
	 util/ncp=/usr/local/bin/ncp
