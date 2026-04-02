#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi
echo "welcome to the huge installation of my linux setup"
read
echo "this setup is what i use on a daily basis"
read
echo "and this script will provide that for your arch linux installation"
read
echo "this requires a proper internet connection so please ensure that you're connected before use. .-."
read
read -p "would you like to proceed?? this may take a while depending on specs: [y/n]" usr_choice1 

if [ "$usr_choice1" == "y" ]; then

	echo "now installing all packages on your system..."
	sleep 3
	pkgs=(
		alacritty base base-devel blueman bluez bluez-obex bluez-utils cava chafa cliphist cmake cmatrix code cowsay cpio discord dotnet-sdk efibootmgr evtest fastfetch firejail fish font-manager fuzzel fzf gimp git grim gst-plugin-pipewire htop hypridle hyprland hyprlock hyprsunset intel-media-driver intel-ucode iwd kanshi kew
		lib32-giflib lib32-gtk3 lib32-libpulse lib32-libxslt lib32-mpg123 lib32-ocl-icd lib32-openal lib32-v4l-utils libpulse libva-intel-driver limine linux-firmware linux-lts linux-lts-headers linuxconsole ly mako mono mpv nano nemo neovim niri ntfs-3g
		nwg-look obs-studio openssh pastel pavucontrol pipewire pipewire-alsa pipewire-jack pipewire-pulse polkit python-pip python-pipx qt5-tools qt6-tools qt6ct retroarch rofi sassc slurp smartmontools starship sudo superfile supertux supertuxkart sway swaybg swayidle swaylock swww tmux
		udiskie vim vulkan-intel vulkan-nouveau vulkan-radeon waybar wev wget wine winetricks wireless_tools wireplumber xdg-desktop-portal-gnome xdg-desktop-portal-hyprland xdg-utils xf86-video-amdgpu xf86-video-ati xf86-video-nouveau xorg-server xorg-xinit xorg-xwayland zram-generator
	)

	aur_pkgs=(
		alacritty base base-devel blueman bluez bluez-obex bluez-utils brave-bin cava chafa cliphist cmake cmatrix code cowsay cpio debtap discord dn-famitracker-bin dotnet-sdk efibootmgr evtest fastfetch firejail fish font-manager fuzzel fzf gimp git grim gst-plugin-pipewire htop hypremoji hypridle hyprland hyprlock hyprmon-bin hyprsunset intel-media-driver intel-ucode iwd kanshi kew
		lib32-giflib lib32-gtk3 lib32-libpulse lib32-libxslt lib32-mpg123 lib32-ocl-icd lib32-openal lib32-v4l-utils libpulse libva-intel-driver limine linux-firmware linux-lts linux-lts-headers linuxconsole ly mako mongodb-bin mono mov-cli mpv mupen64plus nano nemo neovim niri ntfs-3g
		nwg-look obs-studio openssh pastel pavucontrol pipewire pipewire-alsa pipewire-jack pipewire-pulse polkit python-mov-cli-youtube python-pip python-pipx qt5-tools qt6-tools qt6ct quickshell-git retroarch rofi sassc sdl2-jstest slurp smartmontools spotify starship sudo superfile supertux supertuxkart sway sway-colord swaybg swayidle swaylock swww tmux ttf-apple-emoji udiskie vim vulkan-intel vulkan-nouveau vulkan-radeon waypaper wev wget wine winetricks wireless_tools wireplumber xdg-desktop-portal-gnome xdg-desktop-portal-hyprland xdg-utils xf86-video-amdgpu xf86-video-ati xf86-video-nouveau xorg-server xorg-xinit xorg-xwayland yay yay-debug zram-generator zscroll-git
	)

	# Filter out packages that are already in pacman
	aur_pkgs_filtered=()
	for aur_pkg in "${aur_pkgs[@]}"; do
		if [[ ! " ${pkgs[*]} " =~ " ${aur_pkg} " ]]; then
			aur_pkgs_filtered+=("$aur_pkg")
		fi
	done

	for pkg in "${pkgs[@]}"; do
		sudo pacman -S --needed --noconfirm "$pkg"
	done

	for aur_pkg in "${aur_pkgs_filtered[@]}"; do
		yay -S --needed --noconfirm "$aur_pkg"
	done

	python3 -m pip install -r <(python3 -m pip freeze)

	echo " "
	echo "all done :)"
	sleep 2

	echo "incoming the config files..."
	sleep 3

	git clone https://github.com/MariiiYT/mariiconfig.git
	git clone https://github.com/ful1e5/apple_cursor.git	

	git clone https://github.com/ItsZariep/Ilustraciones-icon-theme.git	
	git clone https://github.com/vinceliuice/Graphite-gtk-theme.git

	echo " "
	echo "installing fonts and the 'mariistart' wizard"
	sleep 1

	cd $HOME/mariiconfig/
	mv -f -v /fonts/* /usr/share/fonts
	mv -f -v /other/* /usr/bin/
	sleep 1

	echo " "
	echo "migrating configuation files.."
	sleep 1

	mv -f -v * /.config/
	rm -rf $HOME/.config/.git

	echo "now the finishing touch is that i will add symlinks to improve clarity for your applications to function"
	read
	echo "working on it now"

	sleep 2
	chmod +x $HOME/.config/symlink.sh

	sleep 1
	$HOME/.config/symlink.sh

	sleep 1
	echo " "
	echo "done."

	sleep 2
	echo "you may now enjoy your arch linux with all packages and configurations installed :)"
	rm -rf $HOME/.config/symlink.sh

	sleep 2
	exit
fi

if [ "$usr_choice1" == "n" ]; then
	echo "ill see you when you need me"
	sleep 1
	exit
fi
