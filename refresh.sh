#!/bin/bash

git_init(){	
	read -p "Enter the link of repository: "  remote_link
	git init
	git remote add origin "$remote_link"
	git pull origin master
}

show_repository(){
	remote_link=$(git remote show origin | awk '{print $3}' | sed -n '3p')
	echo "$remote_link"
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

do_merge(){
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

merge_rebase_options(){
	while true; 
	do
    	read -p "Enter number 1 to git merge, or number 2 to git rebase: " nu
    	case $nu in
        	"1" )
				echo "you chose number 1 that is merge"
            	do_merge
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
            	merge_rebase_options
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

		echo -n "There is a git repository: "
		show_repository

        	git_remote_status_results=$(git remote show origin)
        
        	if [[ $git_remote_status_results =~ 'up to date' ]]; then
        	
        		echo "Local repo is Up To Date."
        	else
        	
        		echo "Local repo is Out of Date"
        		do_fetch_pull_options
        	fi
	else
        	echo "There don't have a git repository, You need to create a git repository first, we will do it for you."
        	git_init
	fi
}

main
