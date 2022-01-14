#!/usr/bin/env sh

red="\e[0;91m"
blue="\e[0;94m"
green="\e[0;92m"
reset="\e[0m"

# better echos
notice() {
    echo -e "${red}[!]${reset} $1";
}
okay() {
    echo -e "[${green}OK${reset}] $1";
}
doing() {
    echo -e "${green}-${2:-""}->${reset} $1";
}
skipping() {
    echo -e "${blue}-${2:-""}->${reset} $1";
}

# code below

OS=$(uname)
DISTRO=$(uname -a | awk -F ' ' '{print $2}')

if [ ! "$OS" = "Linux" ] && [ ! "$DISTRO" = "arch" ]; then
	notice "Only Arch Linux is supported, for now."
	exit 1
fi

install_command() {
	sudo pacman -S "${1}" --noconfirm >/dev/null
}

install() {
	doing "Checking for ${1}..."
	if ! command -v "${1}" 1>/dev/null; then
		notice "'${1}' was not found"
		doing "Installing it now..."
		install_command "${1}"
		okay "Installed '${1}'!"
	fi;
}