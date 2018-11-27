#!/bin/bash

git_init(){	
	git init
	git remote add origin https://github.com/zjwda2016/test.git
	git pull origin master
}

git_pull(){
	git pull origin master
}

git_fetch(){
	git fetch origin master
}

git_merge(){
	git merge origin/master
}

git_rebase(){
	git rebase -p origin/master
}

do_merege(){
	while true; 
	do
    	read -p "Do your want to merge the repository(yes or no):" yn
    	case $yn in
        	[Yy]* )
				git_merge
				break;;
        	[Nn]* )
				break;;
        	* ) echo "Please answer yes or no.";;
    	esac
	done
}

do_rebase(){
	while true; 
	do
    	read -p "Do your want to rebase the repository(yes or no):" yn
    	case $yn in
        	[Yy]* )
				git_rebase
				break;;
        	[Nn]* )
				break;;
        	* ) echo "Please answer yes or no.";;
    	esac
	done
}

merege_rebase_options(){
	while true; 
	do
    	read -p "Enter number 1 to git merege, or number 2 to git rebase: " nu
    	case $nu in
        	"1" )
				echo "you chose number 1 that is merege"
            	do_merege
				break;;
        	"2" )
				echo "you chose number 2 that is rebase"
            	do_rebase
				break;;
        	* ) echo "Please enter number 1 or 2.";;
    	esac
	done
}

fetch_pull_options(){
	while true; 
	do
    	read -p "Enter number 1 to git pull, or number 2 to git fetch: " nu
    	case $nu in
        	"1" )
				echo "you chose number 1 that is pull"
            	git_pull
				break;;
        	"2" )
				echo "you chose number 2 that is fetch"
            	git_fetch
            	merege_rebase_options
				break;;
        	* ) echo "Please enter number 1 or 2.";;
    	esac
	done
}

do_fetch_pull_options(){
	while true; 
	do
    	read -p "Do you want to update from remote repository(yes or no):" yn
    	case $yn in
        	[Yy]* )
				fetch_pull_options
				break;;
        	[Nn]* )
				break;;
        	* ) echo "Please answer yes or no.";;
    	esac
	done
}

main(){

	git_status_results=$(git status)

	if [[ $git_status_results =~ 'On branch master' ]]; then

		echo "There have a git repository"

        git_remote_status_results=$(git remote show origin)
        
        if [[ $git_remote_status_results =~ 'up to date' ]]; then
        	
        	echo "Up To Date."
        else
        	
        	echo "Local Out of Date"
        	do_fetch_pull_options
        fi
	else
        echo "There don't have a git repository"
        git_init
	fi
}

main
