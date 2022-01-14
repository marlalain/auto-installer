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
		doing "Installing it now..." "-"
		install_command "${1}"
		okay "Installed '${1}'!"
	else
		skipping "${1} is already installed, skipping..." "-"
	fi;
}