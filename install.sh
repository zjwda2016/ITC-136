#!/bin/bash

download_shell(){
	sudo wget https://raw.githubusercontent.com/zjwda2016/ITC-136/master/refresh.sh
	sudo chmod +x refresh.sh
	sudo wget https://raw.githubusercontent.com/zjwda2016/ITC-136/master/stats.desktop
	sudo chmod +x stats.desktop
	sudo wget https://raw.githubusercontent.com/zjwda2016/ITC-136/master/Sample-Icon.png
}

cp_shell(){
	sudo cp refresh.sh /usr/local/bin/refresh
}

download_shell
cp_shell
