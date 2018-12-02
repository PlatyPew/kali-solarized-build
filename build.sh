# Ensure script is executed in correct directory
DIR="$(cd "$(dirname "$0")" && pwd)"
cd ${DIR}

# Pull modules
git submodule init
git submodule update --remote --recursive

# Include packages
cp rice-kali.list.chroot live-build-config/kali-config/variant-i3wm/package-lists/kali.list.chroot

# Include hooks


# Copy wallpapers
mkdir -p ./live-build-config/kali-config/common/includes.chroot/root/Pictures
mkdir -p ./live-build-config/kali-config/common/includes.binary/root/Pictures
unzip wallpapers.zip -d ./live-build-config/kali-config/common/includes.chroot/root/Pictures
unzip wallpapers.zip -d ./live-build-config/kali-config/common/includes.binary/root/Pictures

# Copy fonts
mkdir -p ./live-build-config/kali-config/common/includes.chroot/root/.local/share/fonts
mkdir -p ./live-build-config/kali-config/common/includes.binary/root/.local/share/fonts
cp 'Inconsolata Nerd Font Complete.otf' ./live-build-config/kali-config/common/includes.chroot/root/.local/share/fonts
cp 'Inconsolata Nerd Font Complete.otf' ./live-build-config/kali-config/common/includes.binary/root/.local/share/fonts

# Install configs
git clone https://github.com/PlatyPew/dotfiles.git ./live-build-config/kali-config/common/includes.chroot/root/.config
git clone https://github.com/PlatyPew/dotfiles.git ./live-build-config/kali-config/common/includes.binary/root/.config

# Install vim plug
curl -fLo ./live-build-config/kali-config/common/root/includes.chroot/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ./live-build-config/kali-config/common/root/includes.binary/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Begin live build
cd live-build-config
#./build.sh --variant i3wm --verbosbinary
