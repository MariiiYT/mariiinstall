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
read -p "would you like to [i]nstall or [u]ninstall? [i/u]" usr_choice1 

if [ "$usr_choice1" == "i" ]; then

	echo "now installing all packages on your system..."
	sleep 3
	
	sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
	pacman -Sy --noconfirm
	sleep 1
	
	if pacman -Qi jack >/dev/null 2>&1; then
		pacman -R --noconfirm jack || true
	fi

	if pacman -Qi jack >/dev/null 2>&1; then
		jack_pkg="jack"
		pacman -R --noconfirm pipewire-jack 2>/dev/null || true
	elif pacman -Qi pipewire-jack >/dev/null 2>&1; then
		jack_pkg="pipewire-jack"
		pacman -R --noconfirm jack 2>/dev/null || true
	else
		jack_pkg="pipewire-jack"
		pacman -R --noconfirm jack 2>/dev/null || true
	fi

	pkgs=(
		alacritty base base-devel blueman bluez bluez-obex bluez-utils cava chafa cliphist cmake cmatrix code cowsay cpio discord dotnet-sdk efibootmgr evtest fastfetch firejail fish font-manager fuzzel fzf gimp git grim gst-plugin-pipewire htop hypridle hyprland hyprlock hyprsunset intel-media-driver intel-ucode iwd kanshi kew
		lib32-giflib lib32-gtk3 lib32-libpulse lib32-libxslt lib32-mpg123 lib32-ocl-icd lib32-openal lib32-v4l-utils libpulse libva-intel-driver limine linux-firmware linux-lts linux-lts-headers linuxconsole ly mako mono mpv nano nemo neovim niri ntfs-3g
		nwg-look obs-studio openssh pastel pavucontrol pipewire pipewire-alsa pipewire-pulse polkit qt5-tools qt6-tools qt6ct retroarch rofi sassc slurp smartmontools starship sudo superfile supertux supertuxkart sway swaybg swayidle swaylock swww tmux
		udiskie vim vulkan-intel vulkan-nouveau vulkan-radeon waybar wev wget wine winetricks wireless_tools wireplumber xdg-desktop-portal-gnome xdg-desktop-portal-hyprland xdg-utils xf86-video-amdgpu xf86-video-ati xf86-video-nouveau xorg-server xorg-xinit xorg-xwayland zram-generator
	)
	pkgs+=("$jack_pkg")

	aur_pkgs=(
		brave-bin debtap hypremoji hyprmon-bin mongodb-bin quickshell-git sdl2-jstest spotify sway-colord ttf-apple-emoji waypaper yay yay-debug zscroll-git
	)

	aur_pkgs_filtered=()
	for aur_pkg in "${aur_pkgs[@]}"; do
		if [[ ! " ${pkgs[*]} " =~ " ${aur_pkg} " ]]; then
			aur_pkgs_filtered+=("$aur_pkg")
		fi
	done

	package_exists() {
		local pkg=$1
		if pacman -Ql "$pkg" 2>/dev/null | cut -d' ' -f2- | grep -q .; then
			return 0  # Package exists
		fi
		return 1  # Package doesn't exist
	}

	for pkg in "${pkgs[@]}"; do
		if ! package_exists "$pkg"; then
			pacman -S --needed --noconfirm "$pkg"
		fi
	done

	for aur_pkg in "${aur_pkgs_filtered[@]}"; do
		if ! package_exists "$aur_pkg"; then
			sudo -u "$SUDO_USER" yay -S --needed --noconfirm "$aur_pkg"
		fi
	done

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

if [ "$usr_choice1" == "u" ]; then
	echo "WARNING: This will uninstall all packages and remove configuration files!"
	read -p "Are you absolutely sure? [y/n]" uninstall_confirm
	
	if [ "$uninstall_confirm" == "y" ]; then
		echo "starting uninstallation process..."
		sleep 3
		
		pkgs=(
			alacritty base base-devel blueman bluez bluez-obex bluez-utils cava chafa cliphist cmake cmatrix code cowsay cpio discord dotnet-sdk efibootmgr evtest fastfetch firejail fish font-manager fuzzel fzf gimp grim gst-plugin-pipewire htop hypridle hyprland hyprlock hyprsunset intel-media-driver intel-ucode iwd kanshi kew
			lib32-giflib lib32-gtk3 lib32-libpulse lib32-libxslt lib32-mpg123 lib32-ocl-icd lib32-openal lib32-v4l-utils libpulse libva-intel-driver limine linux-firmware linux-lts linux-lts-headers linuxconsole ly mako mono mpv nano nemo neovim niri ntfs-3g
			nwg-look obs-studio openssh pastel pavucontrol pipewire pipewire-alsa pipewire-jack pipewire-pulse polkit qt5-tools qt6-tools qt6ct retroarch rofi sassc slurp smartmontools starship superfile supertux supertuxkart sway swaybg swayidle swaylock swww tmux
			udiskie vim vulkan-intel vulkan-nouveau vulkan-radeon waybar wev wget wine winetricks wireless_tools wireplumber xdg-desktop-portal-gnome xdg-desktop-portal-hyprland xdg-utils xf86-video-amdgpu xf86-video-ati xf86-video-nouveau xorg-server xorg-xinit xorg-xwayland zram-generator
		)

		aur_pkgs=(
			brave-bin debtap hypremoji hyprmon-bin mongodb-bin quickshell-git sdl2-jstest spotify sway-colord ttf-apple-emoji waypaper yay yay-debug zscroll-git
		)

		echo "removing pacman packages..."
		for pkg in "${pkgs[@]}"; do
			pacman -R --noconfirm "$pkg" 2>/dev/null || true
		done

		echo "removing AUR packages..."
		for aur_pkg in "${aur_pkgs[@]}"; do
			pacman -R --noconfirm "$aur_pkg" 2>/dev/null || true
		done

		echo "removing configuration files..."
		rm -rf $HOME/mariiconfig
		rm -rf $HOME/apple_cursor
		rm -rf $HOME/Ilustraciones-icon-theme
		rm -rf $HOME/Graphite-gtk-theme
		rm -rf $HOME/.config/symlink.sh

		echo " "
		echo "uninstallation complete!"
		sleep 2
		exit
	else
		echo "uninstallation cancelled"
		sleep 1
		exit
	fi
fi

if [ "$usr_choice1" == "n" ]; then
	echo "ill see you when you need me"
	sleep 1
	exit
fi
