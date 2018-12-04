# Ensure script is executed in correct directory
DIR="$(cd "$(dirname "$0")" && pwd)"
cd ${DIR}

# Pull modules
git submodule init
git submodule update --remote --recursive

# Include packages
cp rice-kali.list.chroot ./live-build-config/kali-config/variant-i3wm/package-lists/kali.list.chroot

# Include hooks
cp rice-i3gaps.chroot ./live-build-config/kali-config/common/hooks/rice-i3gaps.chroot
cp rice-neovim.chroot ./live-build-config/kali-config/common/hooks/rice-neovim.chroot
cp rice-ohmyzsh.chroot ./live-build-config/kali-config/common/hooksrice-ohmyzsh.chroot/
cp rice-termite.chroot ./live-build-config/kali-config/common/hooksrice-termite.chroot/
chmod 755 ./live-build-config/kali-config/common/hooks/rice-*

# Copy wallpapers
mkdir -p ./live-build-config/kali-config/common/includes.chroot/root/Pictures
unzip wallpapers.zip -d ./live-build-config/kali-config/common/includes.chroot/root/Pictures

# Copy fonts
mkdir -p ./live-build-config/kali-config/common/includes.chroot/root/.local/share/fonts
cp 'Inconsolata Nerd Font Complete.otf' ./live-build-config/kali-config/common/includes.chroot/root/.local/share/fonts

# Install configs
git clone https://github.com/PlatyPew/dotfiles.git ./live-build-config/kali-config/common/includes.chroot/root/.config

# Install vim plug
curl -fLo ./live-build-config/kali-config/common/root/includes.chroot/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Begin live build
cd live-build-config
./build.sh --variant i3wm --verbose
