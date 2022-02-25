#!/bin/sh
# Script to auto-update and generate fonts for installation via an Arch Linux build script.
# Contributions for other distributions welcome :)
# https://github.com/jtbx/jetbrainsmono-nerdfont

## Config
# Auto commit? Options are enabled or disabled
GIT_AUTOCOMMIT="enabled"
# Auto commit message
GIT_AUTOCOMMIT_MSG="Generated and updated font repository"
# Push? true or false only
PUSH_TO_GIT_REPO="true"

set -e

# Functions

msg_check()
{
	TEXT=$1
	printf "\t\033[32;1m✓\033[0m \033[1m$TEXT\033[0m\n"
}

msg1()
{
	TEXT=$1
	printf "\t\033[32;1m*\033[0m \033[1m$TEXT\033[0m\n"
}

msg2()
{
	TEXT=$1
	printf "\t\033[34;1m*\033[0m \033[1m$TEXT\033[0m\n"
}

error()
{
	TEXT=$1
	printf "\t\033[31;1m*\033[0m \033[1m$TEXT\033[0m\n"
}

inputInto()
{
	printf "\t\033[34;1m->\033[0m"
	read -p " " $1
}

enterPrompt()
{
	printf "\t\033[34;1m>\033[0;1m Press Enter to begin \033[34;1m<\033[0m"
	read -p "" tempvar
}

confirmation()
{
	msg2 $1
	printf "\t\033[34;1m->\033[0m"
	read -p " " confirmChoice
	case $confirmChoice in
		y)
			doNothing
			;;
		Y)
			doNothing
			;;
		n)
			doNothing
			;;
		N)
			doNothing
			;;
		*)
			error "Invalid choice. Exiting..." ; exit 1
			;;
	esac
}

# End functions

# Begin
clear
msg1 "JetBrainsMono Nerd Font Repository Generation Script\n\t  https://github.com/jtbx/jetbrainsmono-nerdfont\n"
msg2 "Warning: this script MUST be run in the cloned repository's directory!"
enterPrompt
if [ -e .git ];
	then msg1 "Repository check completed with success."; GIT_REPO_LOCATION=$(pwd);
	else error "Error; not in repository folder. Try running this in the repository's folder."; exit 1;
fi

# Clean up
msg1 "Cleaning..."
rm -rf *.ttf

# Download font archive
msg1 "Downloading font archive..."
cd $(mktemp -d)
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
msg1 "Extracting font archive..."
unzip JetBrainsMono.zip
# Remove Windows compatible and original archive
rm -vrf *Compatible.ttf JetBrainsMono.zip
msg1 "Copying TrueType fonts to local repository..."
mkdir -pv   "$GIT_REPO_LOCATION/ttf/"
cp -v *.ttf "$GIT_REPO_LOCATION/ttf/"

# AutoCommit
if [ $GIT_AUTOCOMMIT = "enabled" ];
then
printf "\n\n\n\n\n\n\n\n\n\n\n\n\n"
msg1 "AutoCommit will start now. To abort AutoCommit, press ^C."
enterPrompt
cd $GIT_REPO_LOCATION
git commit -am "[AutoCommit] $GIT_AUTOCOMMIT_MSG"
[ $PUSH_TO_GIT_REPO = "true" ] && git push
msg_check "Completed!"
else
msg2 "Git AutoCommit has been disabled in the script. Exiting now..."
exit 1
fi
